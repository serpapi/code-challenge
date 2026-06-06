require "set"

module Code
  module Challenge
    # Extracts deferred image mappings from inline scripts that invoke
    # _setImagesSrc(...). Returns a hash of img element id => data URI.
    class DeferredImageExtractor
      DATA_URI_PATTERN = /['"](data:image[^'"]+)['"]/.freeze
      IDENTIFIER_PATTERN = /[A-Za-z_$][A-Za-z0-9_$]*/.freeze

      def self.extract(document)
        new(document).extract
      end

      def initialize(document)
        @document = document
        @known_image_ids = @document.css("img[id]").map { |img| img["id"] }.to_set
      end

      def extract
        images = {}
        @document.css("script").each do |script_node|
          script = script_node.text
          next unless script.include?("data:image") && script.include?("_setImagesSrc")

          deferred_pairs(script).each do |element_id, data_uri|
            images[element_id] = unescape_js_string(data_uri)
          end
        end
        images
      end

      private

      # Parse each _setImagesSrc(...) call independently by behavior rather than
      # fixed variable names or argument order. For each call, resolve IDs and
      # data URI from direct literals first, then from variable assignments
      # found in the enclosing scope before the call site.
      def deferred_pairs(script)
        results = []
        pattern = /_setImagesSrc\s*\(([^)]*)\)/
        cursor = 0

        while (m = pattern.match(script, cursor))
          call_pos = m.begin(0)
          args = m[1].split(",").map(&:strip)
          ids = ids_from_args(script, call_pos, args)

          if ids.any?
            data_uri = data_uri_from_args(script, call_pos, args)
            if data_uri.nil? || data_uri.empty?
              raise StructuralMismatchException, "Unable to resolve deferred data URI for ids: #{ids.join(', ')}"
            end

            results.concat(ids.map { |id| [id, data_uri] })
          end

          cursor = m.end(0)
        end

        results
      end

      def data_uri_from_args(script, call_pos, args)
        args.each do |arg|
          # Simple case when the argument is a data URI.
          return arg[DATA_URI_PATTERN, 1] if arg.match?(DATA_URI_PATTERN)

          # Otherwise, the argument may be a variable name; do a reverse scan
          # of the script from call_pos to find the variable assignment.
          scope_start = find_enclosing_scope_start(script, call_pos)
          window = script[scope_start...call_pos]
          uri_by_var = data_uri_assignments(window)
          return uri_by_var[arg] if uri_by_var.key?(arg)
        end
        nil
      end

      def data_uri_assignments(window)
        mappings = {}
        window.scan(/(?:(?:var|let|const)\s+)?(#{IDENTIFIER_PATTERN})\s*=\s*['"](data:image[^'"]+)['"]/) do |var_name, data_uri|
          mappings[var_name] = data_uri
        end
        mappings
      end

      def ids_from_args(script, call_pos, args)
        args.each do |arg|
          # The argument may be an array literal; scan it for known image IDs
          ids = known_ids_in(arg)
          return ids unless ids.empty?

          # Otherwise, the argument may be a variable name; do a reverse scan
          # of the script from call_pos to find the variable assignment.
          scope_start = find_enclosing_scope_start(script, call_pos)
          window = script[scope_start...call_pos]
          ids_by_var = id_array_assignments(window)
          return ids_by_var[arg] if ids_by_var.key?(arg)
        end
        []
      end

      def id_array_assignments(window)
        mappings = {}
        window.scan(/(?:(?:var|let|const)\s+)?(#{IDENTIFIER_PATTERN})\s*=\s*(\[[^\]]*\])/) do |var_name, array_literal|
          ids = known_ids_in(array_literal)
          mappings[var_name] = ids unless ids.empty?
        end
        mappings
      end

      def find_enclosing_scope_start(script, call_pos)
        pos = [[call_pos.to_i - 1, 0].max, script.length - 1].min
        depth = 0
        quote = nil

        escaped = lambda do |index|
          slashes = 0
          j = index - 1
          while j >= 0 && script[j] == "\\"
            slashes += 1
            j -= 1
          end
          slashes.odd?
        end

        while pos >= 0
          ch = script[pos]

          if quote
            quote = nil if ch == quote && !escaped.call(pos)
          else
            if (ch == "'" || ch == "\"" || ch == "`") && !escaped.call(pos)
              quote = ch
            elsif ch == "}"
              depth += 1
            elsif ch == "{"
              return pos if depth.zero?
              depth -= 1
            end
          end

          pos -= 1
        end

        0
      end

      def known_ids_in(text)
        text.scan(/['"]([^'"]+)['"]/).flatten.select { |value| @known_image_ids.include?(value) }
      end

      def unescape_js_string(value)
        value.gsub(/\\x([0-9a-fA-F]{2})/) { [Regexp.last_match(1).hex].pack("C") }
      end
    end
  end
end
