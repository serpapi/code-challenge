require "nokogiri"
require_relative "deferred_image_extractor"

module Code
  module Challenge
    class StructuralMismatchException < StandardError; end

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

      def self.parse(html)
        new(html).parse
      end

      def initialize(html)
        @html = html
        @document = Nokogiri::HTML(html)
        @deferred_images = DeferredImageExtractor.extract(@document)
      end

      def parse
        entries = @document.css("a").filter_map { |anchor| build_entry(anchor) }
        if entries.empty?
          raise StructuralMismatchException, "No entries matched the expected carousel structure"
        end

        entries
      end

      private

      def build_entry(anchor)
        return nil unless carousel_candidate?(anchor)

        labels = text_labels(anchor)
        return nil if labels.empty?

        name = labels.first
        return nil if name.nil? || name.empty?

        entry = {
          "name" => name,
          "link" => absolute_link(anchor["href"])
        }

        extension = labels[1]
        entry["extensions"] = [extension] if extension && !extension.empty?

        image = image_source(anchor.at_css("img"))
        if image.nil? || image.empty?
          raise StructuralMismatchException, "Missing image source for entry '#{name}'"
        end
        entry["image"] = image

        entry
      end

      # An anchor matches the expected carousel structure when it is a Google
      # search link that wraps a thumbnail image and at least one text label.
      def carousel_candidate?(anchor)
        search_link?(anchor["href"]) &&
          !anchor.at_css("img").nil?
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
    end
  end
end
