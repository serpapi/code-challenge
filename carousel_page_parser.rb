# frozen_string_literal: true

class CarouselPageParser
  NODES_XPATH = '//g-scrolling-carousel/div/div/div' # Gets the carousel items

  # Expects `html` to be a Nokogiri::HTML object
  def initialize(html)
    @html = html
  end

  def parse
    collected_results = []

    carousel_items = @html.search("g-scrolling-carousel/div a")

    carousel_items.each do |item|
      result = parse_a(item)
      data = extract_result_data(result)

      collected_results << data
    end

    collected_results
  end

  private

  def parse_a(a_element)
    a_attributes = a_element.attributes.map { |k, v| [k, v&.text] }.to_h

    img_element = a_element.at('img')
    img_attributes = img_element.attributes.map { |k, v| [k, v&.text] }.to_h

    {
      "a" => a_attributes,
      "img" => img_attributes
    }
  end

  def extract_result_data(result)
    name = result['a']['aria-label']

    title = result['a']['title']

    additional_text = title.gsub(name, '').strip
    additional_text.tr!('()', '')

    extensions = [additional_text]

    google_base_url = 'https://www.google.com'
    url = result['a']['href']
    link = "#{google_base_url}#{url}"
    image = result['img']['src']

    {
      "name" => name,
      "extensions" => extensions,
      "link" => link,
      "image" => image
    }
  rescue NoMethodError => e

  end
end
