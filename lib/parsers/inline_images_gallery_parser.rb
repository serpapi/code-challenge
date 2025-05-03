# frozen_string_literal: true

# This class demonstrates a slightly different approach to code organization.
# It introduces Element instance methods instead of utility methods.
# Both approaches are valid, and encapsulation is key - parsers can determine their own implementation details.
# This Element class approach can be made reusable for other/next parsers as well.
class InlineImagesGalleryParser < BaseGalleryParser
  def self.elements_selector
    'div#iur div[data-docid]'
  end

  def as_json
    { inline_images: data }
  end

  def element_data(element)
    Element.new(element).as_json
  end

  class Element
    def initialize(dom_element)
      @element = dom_element
      @page = @element.page
    end

    def as_json
      {
        source: source,
        thumbnail: thumbnail,
        original: original,
        title: title,
        source_name: source_name
      }
    end

    def source
      @element.at_css('a')['href']
    end

    def thumbnail
      image_data.dig(1, 2, 0)
    end

    def original
      image_data.dig(1, 3, 0)
    end

    def title
      @element.at_css('img').attribute('alt')
    end

    def source_name
      @element.at_css('a').xpath('../div/div/div')&.last&.text&.strip&.gsub(/\s+/, ' ')
    end

    private

    def window_javascript_data_id
      @window_javascript_data_id ||= @element.attribute('jsdata').split(';').last
    end

    def window_javascript_data
      @window_javascript_data ||= @page.evaluate('W_jd')
    end

    def image_data
      @image_data ||= displayed_image_data || hidden_image_data
    end

    def displayed_image_data
      @displayed_image_data ||= window_javascript_data[window_javascript_data_id]
    end

    # ATTENTION: This relies heavily on the page's JavaScript code
    # Hidden images' data is not automatically added to window.W_jd
    # This method extracts data by parsing the JavaScript code
    # Solution works but is fragile
    # Regular automated e2e testing recommended to detect Google's JavaScript changes
    # There might be a way to trigger the code execution for hidden images, but I'm limited by time.
    def hidden_image_data
      @hidden_image_data ||= begin
        js = @page.body.scan(/(window\['W_jd'\]\['#{window_javascript_data_id}'\] ?= ?([^;]+;))/)
        js_data = js.dig(0, 1)

        @page.evaluate(js_data)
      end
    end
  end
end
