require 'nokolexbor'
require_relative 'carousel_extractor'

class CarouselScraper
  include CarouselExtractor

  attr_accessor :html_content, :carousel_content

  def scrape(html_content)
    carousel = get_carousel(html_content)
    assert_content_presence(carousel, 'Failed to get carousel from HTML content')

    heading = get_carousel_heading(carousel)
    assert_content_presence(heading, 'Failed to get carousel heading')

    carousel_content = get_carousel_content(carousel)
    assert_content_presence(carousel_content, 'Failed to get carousel content')

    mapped_carousel_content = map_carousel_content(carousel_content)

    { heading => mapped_carousel_content }

  rescue => e
    puts "Error occurred: #{e.message}"
    nil
  end

  private

  def assert_content_presence(content, error_message)
    raise error_message unless content
  end

  def get_name(item)
    item['aria-label'] || item['title'] || ""
  end

  def get_image_link(item)
    image = item.at_css('img') || ""
    image['data-key'] || image['src'] || ""
  end

  def map_carousel_content(carousel_content)
    carousel_content.map do |item|
      text_nodes = item.last_element_child
      last_div_with_text = text_nodes.css('div').select { |div| !div.text.strip.empty? }.last

      name = get_name(item)
      href = item['href'] || ""
      image = get_image_link(item)

      {
        "name" => name,
        "extensions" => [last_div_with_text.text.strip],
        "link" => "https://www.google.com" + href,
        "image" => image
      }
    end
  end
end
