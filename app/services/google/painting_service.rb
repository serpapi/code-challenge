# frozen_string_literal: true

module Google
  class PaintingService
    GOOGLE_LINK = 'https://www.google.com'

    def html_to_json(html)
      {
        name: get_name(html),
        extensions: [
          get_year(html)
        ],
        link: get_link(html),
        image: get_image(html)
      }
    end

    private

    def get_name(html)
      tag_sanitizer_service.tags_sanitize(
        drill_service.pick(
          html,
          [
            { element: 'a', strategy: 'drill' },
            { element: 'div', strategy: 'skip' },
            { element: 'div', strategy: 'drill' },
            { element: 'div', strategy: 'drill' }
          ]
        )
      )
    end

    def get_year(html)
      tag_sanitizer_service.tags_sanitize(
        drill_service.pick(
          html,
          [
            { element: 'a', strategy: 'drill' },
            { element: 'div', strategy: 'skip' },
            { element: 'div', strategy: 'drill' },
            { element: 'div', strategy: 'skip' }
          ]
        )
      )
    end

    def get_link(html)
      value = tag_attribute_service.get_attribute_value(html, 'href')
      value && GOOGLE_LINK + value
    end

    def get_image(html)
      tag_attribute_service.get_attribute_value(
        drill_service.pick(
          html,
          [
            { element: 'a', strategy: 'drill' },
            { element: 'div', strategy: 'drill' },
            { element: 'div', strategy: 'drill' },
            { element: 'g-img', strategy: 'drill' }
          ]
        ),
        'src'
      )
    end

    def drill_service
      @drill_service ||= DrillService.new
    end

    def tag_sanitizer_service
      @tag_sanitizer_service ||= TagSanitizerService.new
    end

    def tag_attribute_service
      @tag_attribute_service ||= TagAttributeService.new
    end
  end
end