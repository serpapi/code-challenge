module GoogleResultsScraper
  class Scraper
    include Scrapers::Carousel

    def initialize(html)
      @html = Nokogiri::HTML(html)
    end
  end
end
