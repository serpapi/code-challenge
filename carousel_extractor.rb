require 'json'
require 'nokogiri'

class CarouselExtractor
  class InvalidCarouselLocationError < StandardError;end
  class InvalidCarouselItemError < StandardError;end

  # These should work with both the provided html file and current Google formatting.
  BASE_URL = 'https://www.google.com'.freeze
  CAROUSEL_LOCATION = 'g-scrolling-carousel a'.freeze
  EXTENSIONS_LOCATION = 'div.ellip'.freeze

  attr_reader :file_path

  class << self
    def carousels_from_file(file_path)
      extracted_carousel = new(file_path).extract
      JSON.pretty_generate(extracted_carousel)
    end
  end

  def initialize(file_path)
    @file_path = file_path
  end

  def extract
    preprocess!
    extract_carousel
  end

  private

  attr_reader :carousel_element, :document

  def preprocess!
    @carousel_element = document.css(CAROUSEL_LOCATION)
    if carousel_element.empty?
      raise InvalidCarouselLocationError.new('Carousel not found, CAROUSEL_LOCATION may need to be adjusted.')
    end
  end

  def document
    @document ||= begin
                    html = File.read(file_path)
                    Nokogiri::HTML(html)
                  end
  end

  def extract_carousel
    carousel_element.each_with_object([]) do |element, collection|
      carousel_element = {
        name: retrieve_name(element),
        link: "#{BASE_URL}#{element['href']}",
        image:  retrieve_image(element)
      }
      extensions = retrieve_extensions(element)
      carousel_element.merge!(extensions: extensions) if extensions.any?
      collection << carousel_element
    rescue InvalidCarouselItemError
      next
    end
  end

  def retrieve_name(element)
    name = element['aria-label'] || element['title']
    if name.nil? || name.strip.empty?
      raise InvalidCarouselItemError
    end
    name
  end

  def retrieve_image(element)
    image_element = element.css('img').first
    image_id = image_element['id'] if image_element

    return unless image_id
    find_image_base64_by_id(image_id)
  end

  def find_image_base64_by_id(image_id)
    document.css('script').each do |script_element|
      script_content = script_element.inner_html

      next unless script_content.include?(image_id)

      regex = /var s='(data:image\/[^']+)';var ii=\['#{image_id}'\];_setImagesSrc\(ii,s\);/
      match = script_content.match(regex)
      return unless match
      return match[1].gsub('\\', '')
    end
    nil
  end

  def retrieve_extensions(element)
    [
      element.css(EXTENSIONS_LOCATION).first&.text&.strip
    ].compact
  end
end
