module GoogleResultsScraper
  class Scraper
    include Scrapers::Carousel
    include Scrapers::ArtworkMural

    def initialize(html)
      @html = Nokogiri::HTML(html)
    end
  end
end
