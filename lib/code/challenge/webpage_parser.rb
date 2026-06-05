require "nokogiri"
require "set"

module Code
  module Challenge
    # Extracts knowledge-graph carousel entries (artworks, movies, etc.) from a
    # Google search results page.
    #
    # Google's CSS class names are obfuscated and rotate frequently, so matching
    # on them is brittle. Instead, this parser matches entries by their expected
    # *structure*. A carousel entry looks like:
    #
    #   <a href="/search?...q=...">   # links to a Google search for the entry
    #     <img ...>                   # the entry thumbnail
    #     ...
    #     <div>The Starry Night</div> # first text cell  -> name
    #     <div>1889</div>             # optional 2nd cell -> extensions (date)
    #   </a>
    #
    # i.e. a search-link anchor that wraps a thumbnail image and carries one or
    # two short text labels.
    class WebpageParser
      GOOGLE_HOST = "https://www.google.com".freeze
      SEARCH_PATH = "/search".freeze
      DATA_URI_PATTERN = /['"](data:image[^'"]+)['"]/.freeze
      IDENTIFIER_PATTERN = /[A-Za-z_$][A-Za-z0-9_$]*/.freeze

      def self.parse(html)
        new(html).parse
      end

      def initialize(html)
        @html = html
        @document = Nokogiri::HTML(html)
        @known_image_ids = @document.css("img[id]").map { |img| img["id"] }.to_set
        @deferred_images = extract_deferred_images
      end

      def parse
        @document.css("a").filter_map { |anchor| build_entry(anchor) }
      end

      private

      def build_entry(anchor)
        return nil unless carousel_entry?(anchor)

        labels = text_labels(anchor)
        name = labels.first
        return nil if name.nil? || name.empty?

        entry = {
          "name" => name,
          "link" => absolute_link(anchor["href"])
        }

        extension = labels[1]
        entry["extensions"] = [extension] if extension && !extension.empty?

        image = image_source(anchor.at_css("img"))
        entry["image"] = image if image

        entry
      end

      # An anchor matches the expected carousel structure when it is a Google
      # search link that wraps a thumbnail image and at least one text label.
      def carousel_entry?(anchor)
        search_link?(anchor["href"]) &&
          !anchor.at_css("img").nil? &&
          text_labels(anchor).any?
      end

      def search_link?(href)
        href = href.to_s
        href.include?("#{SEARCH_PATH}?") && href.include?("q=")
      end

      # The visible labels are the anchor's leaf elements that hold text (the
      # name and the optional date), returned in document order.
      def text_labels(anchor)
        anchor.css("*").filter_map do |node|
          next unless node.children.all?(&:text?)

          text = node.text.strip
          text unless text.empty?
        end
      end

      def image_source(image_node)
        return nil unless image_node

        deferred = image_node["data-src"]
        return deferred if deferred && !deferred.empty?

        @deferred_images[image_node["id"]]
      end

      def absolute_link(href)
        return nil unless href

        href = href.gsub("&amp;", "&")
        href = "#{GOOGLE_HOST}#{href}" if href.start_with?(SEARCH_PATH)
        href
      end

      # Thumbnails are lazy-loaded: the real base64 payload lives in inline
      # scripts that map an <img> id to its data URI.
      def extract_deferred_images
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

      # Parse a script by behavior rather than variable names:
      # for each _setImagesSrc(...) call, resolve which argument is the data URI
      # and which argument is the id list from local assignments/literals.
      def deferred_pairs(script)
        uri_by_var = data_uri_assignments(script)
        ids_by_var = id_array_assignments(script)

        script.scan(/_setImagesSrc\s*\(([^)]*)\)/).flat_map do |match|
          args = match[0].split(",").map(&:strip)
          data_uri = data_uri_from_args(args, uri_by_var)
          next [] unless data_uri

          ids = ids_from_args(args, ids_by_var)
          ids.map { |id| [id, data_uri] }
        end
      end

      def data_uri_assignments(script)
        mappings = {}
        script.scan(/(?:var\s+)?(#{IDENTIFIER_PATTERN})\s*=\s*['"](data:image[^'"]+)['"]/) do |var_name, data_uri|
          mappings[var_name] = data_uri
        end
        mappings
      end

      def id_array_assignments(script)
        mappings = {}
        script.scan(/(?:var\s+)?(#{IDENTIFIER_PATTERN})\s*=\s*(\[[^\]]*\])/) do |var_name, array_literal|
          ids = known_ids_in(array_literal)
          mappings[var_name] = ids unless ids.empty?
        end
        mappings
      end

      def data_uri_from_args(args, uri_by_var)
        args.each do |arg|
          return arg[DATA_URI_PATTERN, 1] if arg.match?(DATA_URI_PATTERN)
          return uri_by_var[arg] if uri_by_var.key?(arg)
        end
        nil
      end

      def ids_from_args(args, ids_by_var)
        args.each do |arg|
          return ids_by_var[arg] if ids_by_var.key?(arg)

          ids = known_ids_in(arg)
          return ids unless ids.empty?
        end
        []
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
