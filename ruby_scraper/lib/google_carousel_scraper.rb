require 'ferrum'
require 'nokogiri'

class GoogleCarouselScraper
  def initialize html_file
    @html_file = html_file
  end

  def extract
    # instantiate headless browser
    browser = Ferrum::Browser.new
    browser.go_to("file://#{Dir.pwd}/#{@html_file}")

    # parse HTML w/ Nokogiri & close Ferrum browser
    doc = Nokogiri::HTML.parse(browser.body)
    browser.quit

    # Identify Carousel Items
    carousel = doc.xpath("//g-scrolling-carousel")
    carousel_items = carousel.css(".klitem")

    puts(carousel_items.inspect)
  end
end