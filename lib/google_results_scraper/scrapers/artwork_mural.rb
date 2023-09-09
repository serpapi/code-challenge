module GoogleResultsScraper
  module Scrapers
    module ArtworkMural
      VED_MAP = {
        artwork_mural_wrapper: 54353,
      }

      def extract_artworks
        artwork_mural = Util::Ved.find_element_with_type(@html, VED_MAP[:artwork_mural_wrapper])
        return [] if artwork_mural.nil?
        artwork_mural.css('a').map { |node| extract_artwork(node) }.compact
      end

      private

      def extract_artwork(node)
        uri = URI.parse(node['href'])
        return if uri.query.nil?

        uri.scheme = 'https' if uri.scheme.nil?
        uri.host = 'google.com' if uri.host.nil?

        image = node.css('img').first
        name, extensions_text = node.css('div').select { |div| div.children.all?(&:text?) }.map(&:text)

        {
          name: name,
          link: uri.to_s,
          image: image&.[]('src'),
          extensions: extensions_text&.strip&.split(', ') || [],
        }
      end
    end
  end
end
