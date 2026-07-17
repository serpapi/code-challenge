# frozen_string_literal: true

module GoogleSearch
  class InlineImageSources
    # Saved data URIs are large and mostly unescaped, so consume ordinary text
    # in runs instead of making the regular-expression engine advance one
    # character at a time.
    QUOTED_LITERAL_PATTERN = /
      '(?:[^'\\\r\n]*\\[^\r\n])*[^'\\\r\n]*'
      |
      "(?:[^"\\\r\n]*\\[^\r\n])*[^"\\\r\n]*"
    /x
    ID_LIST_PATTERN = /
      (?:
        #{QUOTED_LITERAL_PATTERN}
        (?:\s*,\s*#{QUOTED_LITERAL_PATTERN})*
        \s*,?
      )?
    /x
    # Google stores some image URLs in a small loader sequence: `var s` holds
    # the source, `var ii` holds image element IDs, and `_setImagesSrc` joins
    # them. The complete pattern reads valid assignments; the broader ID-list
    # pattern below catches malformed assignments for images we requested.
    COMPLETE_IMAGE_LOADER_PATTERN = /
      var\s+s\s*=\s*(?<source_literal>#{QUOTED_LITERAL_PATTERN})\s*;
      \s*(?<id_declaration>var\s+ii\s*=\s*\[\s*)
      (?<id_literals>#{ID_LIST_PATTERN})\s*\]\s*;
      \s*(?:var\s+r\s*=\s*#{QUOTED_LITERAL_PATTERN}\s*;\s*)?
      _setImagesSrc\s*\(\s*ii\s*,\s*s(?:\s*,\s*r)?\s*\)\s*;
    /x
    LOADER_MARKER = "_setImagesSrc"
    ID_DECLARATION_PATTERN = /
      (?<id_declaration>var\s+ii\s*=\s*\[\s*)
      (?<id_literals>
        (?:(?!\]|;|_setImagesSrc\s*\(|\bvar\s+(?:s|ii|r)\s*=)[\s\S])*
      )
    /x
    SIMPLE_ESCAPES = [ "\\", "'", '"', "/" ].freeze
    SINGLE_QUOTE_BYTE = "'".ord
    DOUBLE_QUOTE_BYTE = '"'.ord
    HEX_ESCAPE_BYTE = "x".ord
    SIMPLE_ESCAPE_BYTES = SIMPLE_ESCAPES.map(&:ord).freeze

    class LiteralError < StandardError; end
    private_constant :LiteralError

    def initialize(document, requested_image_ids:)
      @document = document
      @requested_image_ids = requested_image_ids.filter_map do |id|
        value = id.to_s
        value unless value.empty?
      end.uniq
      @sources = extract_sources
    end

    def [](id)
      @sources[id]
    end

    def to_h
      @sources.dup
    end

    private
      def extract_sources
        return {} if @requested_image_ids.empty?

        sources = {}
        requested_id_pattern = any_requested_id_pattern

        @document.css("script").each do |script_node|
          script = script_node.text
          next unless script.include?(LOADER_MARKER)
          next unless script.match?(requested_id_pattern)

          matched_id_list_offsets = extract_complete_mappings(script, sources)
          reject_malformed_requested_mappings(script, matched_id_list_offsets)
        end

        sources
      end

      def any_requested_id_pattern
        alternatives = encoded_id_patterns_by_id.values.join("|")
        Regexp.new("(?:#{alternatives})")
      end

      def requested_id_patterns_by_id
        @requested_id_patterns_by_id ||= encoded_id_patterns_by_id.to_h do |id, encoded_id|
          pattern = /(?:'#{encoded_id}(?:'|(?=\s*(?:,|\z)))|"#{encoded_id}(?:"|(?=\s*(?:,|\z))))/

          [ id, pattern ]
        end
      end

      def encoded_id_patterns_by_id
        @encoded_id_patterns_by_id ||= begin
          character_patterns = {}

          @requested_image_ids.to_h do |id|
            encoded_id = id.each_char.map do |character|
              character_patterns[character] ||= encoded_character_pattern(character)
            end.join

            [ id, encoded_id ]
          end
        end
      end

      def encoded_character_pattern(character)
        alternatives = [ Regexp.escape(character) ]
        alternatives << Regexp.escape("\\#{character}") if SIMPLE_ESCAPES.include?(character)

        codepoint = character.ord
        if codepoint <= 0xff
          hexadecimal = format("%02x", codepoint).each_char.map do |digit|
            digit.match?(/[a-f]/) ? "[#{digit}#{digit.upcase}]" : digit
          end.join
          alternatives << "#{Regexp.escape("\\x")}#{hexadecimal}"
        end

        "(?:#{alternatives.join("|")})"
      end

      def extract_complete_mappings(script, sources)
        matched_id_list_offsets = []
        search_offset = 0

        while (match = COMPLETE_IMAGE_LOADER_PATTERN.match(script, search_offset))
          search_offset = match.end(0)

          begin
            image_ids = decode_image_id_list(match[:id_literals])
            requested_ids = image_ids & @requested_image_ids
            next if requested_ids.empty?

            matched_id_list_offsets << match.begin(:id_declaration)
            source = decode_source(match[:source_literal], requested_ids.first)
            requested_ids.each { |id| add_source(sources, id, source) }
          rescue LiteralError
            requested_id = requested_id_in(match[:id_literals])
            raise_mapping_error(requested_id, "has a malformed element ID list") if requested_id
          end
        end

        matched_id_list_offsets
      end

      def reject_malformed_requested_mappings(script, matched_id_list_offsets)
        search_offset = 0

        while (declaration = ID_DECLARATION_PATTERN.match(script, search_offset))
          search_offset = declaration.end(0)
          next if matched_id_list_offsets.include?(declaration.begin(:id_declaration))

          id_literals = declaration[:id_literals]
          requested_id = requested_id_in(id_literals)
          next unless requested_id

          raise_mapping_error(requested_id, "is malformed")
        end
      end

      def decode_image_id_list(id_literals)
        index = 0
        ids = []

        loop do
          index = skip_whitespace(id_literals, index)
          break if index == id_literals.length

          id, index = decode_image_id_at(id_literals, index)
          ids << id
          index = skip_whitespace(id_literals, index)
          break if index == id_literals.length

          raise LiteralError unless id_literals[index] == ","

          index += 1
        end

        ids
      end

      def decode_source(source_literal, requested_id)
        source = decode_source_literal(source_literal)
        raise_mapping_error(requested_id, "has a malformed source string") if source.empty?

        source
      rescue LiteralError
        raise_mapping_error(requested_id, "has an unsupported or malformed string escape")
      end

      def decode_source_literal(literal)
        quote = literal.getbyte(0)
        closing_quote_index = literal.bytesize - 1
        unless quote == SINGLE_QUOTE_BYTE || quote == DOUBLE_QUOTE_BYTE
          raise LiteralError
        end
        raise LiteralError unless closing_quote_index.positive? && literal.getbyte(closing_quote_index) == quote

        value = String.new(capacity: closing_quote_index - 1, encoding: literal.encoding)
        chunk_start = 1

        while (escape_index = literal.byteindex("\\", chunk_start)) && escape_index < closing_quote_index
          append_source_chunk(value, literal, chunk_start, escape_index)
          chunk_start = append_source_escape(value, literal, escape_index, closing_quote_index)
        end

        append_source_chunk(value, literal, chunk_start, closing_quote_index)
        value
      end

      def append_source_chunk(value, literal, chunk_start, chunk_end)
        return if chunk_start == chunk_end

        value << literal.byteslice(chunk_start, chunk_end - chunk_start)
      end

      def append_source_escape(value, literal, index, closing_quote_index)
        escape = literal.getbyte(index + 1)
        raise LiteralError unless escape && index + 1 < closing_quote_index

        if escape == HEX_ESCAPE_BYTE
          append_source_hex_escape(value, literal, index, closing_quote_index)
          index + 4
        elsif SIMPLE_ESCAPE_BYTES.include?(escape)
          value << literal.byteslice(index + 1, 1)
          index + 2
        else
          raise LiteralError
        end
      end

      def append_source_hex_escape(value, literal, index, closing_quote_index)
        raise LiteralError unless index + 3 < closing_quote_index

        high = hexadecimal_value(literal.getbyte(index + 2))
        low = hexadecimal_value(literal.getbyte(index + 3))
        raise LiteralError unless high && low

        value << ((high << 4) | low).chr(Encoding::UTF_8)
      end

      def hexadecimal_value(byte)
        case byte
        when 48..57
          byte - 48
        when 65..70
          byte - 55
        when 97..102
          byte - 87
        end
      end

      def decode_image_id_at(literal, index)
        quote = literal[index]
        raise LiteralError unless quote == "'" || quote == '"'

        value = +""
        index += 1

        while index < literal.length
          character = literal[index]

          if character == quote
            return [ value, index + 1 ]
          elsif character == "\\"
            index = append_image_id_escape(value, literal, index)
          elsif character == "\n" || character == "\r"
            raise LiteralError
          else
            value << character
            index += 1
          end
        end

        raise LiteralError
      end

      def append_image_id_escape(value, literal, index)
        escape = literal[index + 1]
        raise LiteralError unless escape

        if escape == "x"
          digits = literal[index + 2, 2]
          raise LiteralError unless digits&.match?(/\A[0-9a-fA-F]{2}\z/)

          value << digits.to_i(16).chr(Encoding::UTF_8)
          index + 4
        elsif SIMPLE_ESCAPES.include?(escape)
          value << escape
          index + 2
        else
          raise LiteralError
        end
      end

      def skip_whitespace(value, index)
        index += 1 while index < value.length && value[index].match?(/\s/)
        index
      end

      def requested_id_in(id_literals)
        requested_id_patterns_by_id.find do |_id, pattern|
          id_literals.match?(pattern)
        end&.first
      end

      def add_source(sources, id, source)
        existing_source = sources[id]

        if existing_source && existing_source != source
          raise_mapping_error(id, "has conflicting source strings")
        end

        sources[id] = source
      end

      def raise_mapping_error(id, reason)
        label = id.to_s.each_char.take(80).join
        raise InlineImageSourceError, "Image source for element ID #{label.inspect} #{reason}."
      end
  end
end
