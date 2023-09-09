module GoogleResultsScraper
  class Scraper
    def initialize(html)
      @html = html
    end

    def extract
      scrapers.map { |key, scraper| [key, scraper.new(@html).extract] }.to_h
    end

    private

    def scrapers
      {
        carousels: Scrapers::Carousel,
        artworks: Scrapers::ArtworkMural
      }
    end
  end
end
