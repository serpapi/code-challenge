# frozen_string_literal: true

require 'json'
require 'nokolexbor'
require_relative 'extracted_result'

module GoogleSearch
  # Extracts knowledge-graph artwork carousel items from a saved Google
  # search results page.
  class Extract
    CAROUSEL_SELECTOR = 'div[data-attrid="kc:/visual_art/visual_artist:works"]'
    INLINE_IMAGE_PATTERN = %r{var s='(data:image/[^']+)';var ii=\['([^']+)'\]}
    BASE_URL = 'https://www.google.com'

    def initialize(file)
      @html = file.respond_to?(:read) ? file.read : File.read(file)
    end

    def results
      @results ||= parse
    end

    def to_h
      { artworks: results.map(&:to_h) }
    end

    def to_json(*)
      to_h.to_json(*)
    end

    private

    def parse
      document = Nokolexbor::HTML(@html)
      carousel = document.at_css(CAROUSEL_SELECTOR)
      return [] unless carousel

      inline_images = inline_image_map(document)
      carousel.css('a[href]').filter_map do |anchor|
        image_node = anchor.at_css('img')
        build_result(anchor, image_node, inline_images) if image_node
      end
    end

    def build_result(anchor, image_node, inline_images)
      name, *extensions = caption_texts(anchor)
      ExtractedResult.new(
        name: name || image_node['alt'],
        extensions: extensions.empty? ? nil : extensions,
        link: absolute_link(anchor['href']),
        image: image_for(image_node, inline_images)
      )
    end

    def caption_texts(anchor)
      anchor.css('div')
            .reject { |div| div.at_css('div') }
            .map { |div| div.text.strip }
            .reject(&:empty?)
    end

    def absolute_link(href)
      href.start_with?('/') ? "#{BASE_URL}#{href}" : href
    end

    # `src` is always a placeholder GIF; real thumbnails live in the inline
    # script map or in `data-src`.
    def image_for(image_node, inline_images)
      inline_images[image_node['id']] || image_node['data-src']
    end

    def inline_image_map(document)
      document.css('script').each_with_object({}) do |script, map|
        script.text.scan(INLINE_IMAGE_PATTERN) do |data_uri, id|
          map[id] = unescape_js(data_uri)
        end
      end
    end

    def unescape_js(string)
      string.gsub(/\\x([0-9a-f]{2})/i) { Regexp.last_match(1).hex.chr }
    end
  end
end
