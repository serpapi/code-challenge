# frozen_string_literal: true

require 'nokogiri'

class GoogleCarouselScraper
  BASE_URL = 'https://www.google.com'

  attr_reader :html_page

  def initialize(html_page)
    @html_page = html_page
  end

  def call
    html = File.read(html_page)
    doc = Nokogiri::HTML(html)
    images = scrape_carousel_images(doc)

    scrape_carousel_elements(doc, images)
  end

  private

  def scrape_carousel_elements(doc, images)
    carousel = doc.css('#extabar g-scrolling-carousel')
    elements = carousel.first.css('a')

    elements.map do |element|
      construct_element_hash(element, images)
    end
  end

  def construct_element_hash(element, images)
    {
      "name": element['aria-label'],
      "link": "#{BASE_URL}#{element['href']}",
      "image": retrieve_image_link(images, element)
    }.tap do |hash|
      extensions = element.css('.ellip').text
      hash[:extensions] = [extensions] unless extensions.empty?
    end
  end

  def retrieve_image_link(images, element)
    images.find { |x| x[:id] == element.css('img').attr('id')&.value }&.fetch(:link, 'null')
  end

  def scrape_carousel_images(doc)
    doc.css('script').map do |script|
      content = script.content
      next unless content.include?('_setImagesSrc')

      parse_script_content(content)
    end.flatten.compact
  end

  def parse_script_content(content)
    content.scan(/var s='(.*?)';var ii=\[(.*?)\];_setImagesSrc\(ii,s\);/).map do |link, ids|
      construct_image_object(link, ids)
    end
  end

  def construct_image_object(link, ids)
    ids.split(',').map(&:strip).map do |id|
      { id: id.gsub("'", ''), link: link.gsub('\\', '') }
    end
  end
end
