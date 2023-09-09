module GoogleResultsScraper
  module Scrapers
    module Carousel
      VED_MAP = {
        carousel_wrapper: 2924,
        carousel_item: 2936,
        carousel_breadcrumb_title: 6102,
      }

      def extract_carousels
        Util::Ved.elements_with_type(@html, VED_MAP[:carousel_wrapper])
          .map { |node| extract_carousel(node) }
          .reject { |carousel| carousel[:title].empty? }
      end

      private

      def extract_carousel(node)
        {
          title: Util::Ved.find_element_with_type(node, VED_MAP[:carousel_breadcrumb_title])&.parent&.children&.map(&:text)&.last&.strip,
          items: Util::Ved
            .elements_with_type(node, VED_MAP[:carousel_item]).map { |item|
              uri = URI.parse(item['href'])
              next if uri.query.nil?

              uri.scheme = 'https' if uri.scheme.nil?
              uri.host = 'google.com' if uri.host.nil?
              image = item.css('img').first
              name = (item['data-entityname'] || data['aria-label']).strip

              {
                name: name,
                link: uri.to_s,
                image: image&.[]('data-src') || image&.[]('src'),
                extensions: item.text.sub(name, '').strip.split(', '),
              }
            }
            .compact
        }
      end
    end
  end
end
