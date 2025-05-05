# frozen_string_literal: true

class InlineImagesGalleryParser < BaseGalleryParser
  def self.elements_selector
    'div#iur div[data-docid]'
  end

  def as_json
    { inline_images: data }
  end

  def element_data(element)
    image_js_data = image_data(element)

    {
      source: element_source(element),
      thumbnail: image_js_data.dig(1, 2, 0),
      original: image_js_data.dig(1, 3, 0),
      title: element_title(element),
      source_name: element_source_name(element)
    }
  end

  private

  def element_source(element)
    element.at_css('a')['href']
  end

  def element_title(element)
    element.at_css('img').attribute('alt')
  end

  def element_source_name(element)
    element.at_css('a').xpath('../div/div/div')&.last&.text&.strip&.gsub(/\s+/, ' ')
  end

  def element_window_javascript_data_id(element)
    element.attribute('jsdata').split(';').last
  end

  def image_data(element)
    images_data[element_window_javascript_data_id(element)]
  end

  def displayed_image_data(element)
    displayed_images_data[element_window_javascript_data_id(element)]
  end

  def hidden_image_data(element)
    hidden_images_data[element_window_javascript_data_id(element)]
  end

  def images_data
    @images_data ||= displayed_images_data.merge(hidden_images_data)
  end

  def displayed_images_data
    @displayed_images_data ||= @page.evaluate('W_jd')
  end
  
  # WARNING: This code heavily relies on the page's JavaScript code.
  # For hidden images, their data is not present in W_jd in the initial page state.
  # I am scanning the page for key => data pairs and then evaluating the JavaScript data code for every key.
  # This code is a bit of a hack, but it works for now.
  # It is only a matter of time before Google changes their code.
  # Automated E2E tests are recommended for early detection of changes.
  # The SerpAPI team might know better ways to deal with hidden elements.
  def hidden_images_data
    @hidden_images_data ||= begin
      # this scans the page for pairs key => data
      pairs = @page.body.scan(/window\['W_jd'\]\[\'([0-9a-zA-Z]+)\'\] ?= ?([^\;]+\;)/)

      # this evaluates data javascript code for every key
      Hash[pairs.map { |w_jd_id, js_value| [w_jd_id, @page.evaluate(js_value)] }]
    end
  end
end
