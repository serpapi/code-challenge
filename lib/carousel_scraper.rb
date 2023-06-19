require 'nokolexbor'
require_relative 'carousel_extractor'

class CarouselScraper
  include CarouselExtractor

  attr_accessor :html_content, :carousel_content

  def scrape(html_content)
    carousel = get_carousel(html_content)
    raise 'Failed to get carousel from HTML content' unless carousel

    heading = get_carousel_heading(carousel)
    raise 'Failed to get carousel heading' unless heading
    carousel_content = get_carousel_content(carousel)
    raise 'Failed to get carousel content' unless carousel_content

    mapped_carousel_content = map_carousel_content(carousel_content)

    {
      heading => mapped_carousel_content
    }
  rescue => e
    puts "Error occurred: #{e.message}"
    nil
  end

  private

  def map_carousel_content(carousel_content)
    carousel_content.map do |item|
      name = item['aria-label']
      href = item['href']
      image = item.at_css('img')['data-key']

      {
        "name" => name,
        "extensions" => [item.css('div.klmeta').text],
        "link" => "https://www.google.com" + href,
        "image" => image
      }
    end
  end

end