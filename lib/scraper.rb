require_relative "./scrapers/carousel"

class Scraper
  include Scrapers::Carousel

  def initialize(file_path)
    @file = File.read(file_path)
  end
end
