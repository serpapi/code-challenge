# frozen_string_literal: true

module Parser
  module Google
    # TODO: This parser works with Artwork type of layout.
    # There're plenty of different carousel types:
    #   -- Albums
    #   -- Songs
    #   ....
    #
    # To make this working with each carousel type available
    # this parser should detect the type and choose related parser implementation for it

    class Carousel
      def initialize(page_api:, data:, params: {})
        @page_api = page_api
        @data = data
        @params = params
      end

      def parse
        page = @page_api.new(@data)

        @params[:base_url] ||= Utils.get_base_url(page)

        elements = page.css('g-loading-icon + div > div').flat_map(&method(:build_element))

        category = get_category(page)

        Parser::Response.new({ category => elements })
      rescue StandardError => e
        Parser::Error.new(e)
      end

      private

      def get_category(page)
        case page.css('div [jscontroller] div[aria-level="2"][role="heading"]').to_a
        in [_, category, *_]
          category.text
        else
          'elements' # default collection category
        end
      end

      def build_element(element)
        case query_element_details(element)
        in [link], [image], [name, *extensions]
          [{
            'name' => name.text,
            'link' => Utils.add_host(link['href'], @params),
            'image' => image['src'],
            'extentions' => extensions.map(&:text).reject { |v| v == '' }
          }]
        else
          []
        end
      end

      def query_element_details(element)
        [
          element.css('a'),
          element.css('a img'),
          element.css('a > div div')
        ].map(&:to_a)
      end
    end
  end
end
