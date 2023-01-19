require 'ferrum'
require 'nokogiri'

class GoogleCarouselScraper
  def initialize html_file
    @html_file = html_file
    @results = []
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

    carousel_items.each do |carousel_item|
      self.parse_carousel_item(carousel_item)
    end

  end

  def parse_carousel_item(carousel_item)
    # parse data from carousel item
    title = carousel_item.css(".kltat").text

    # create hash with data
    h = {
      name: title
    }

    # add hash to @results array
    @results.push(h)
  end
end