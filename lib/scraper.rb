require_relative "./scrapers/carousel"
require "nokogiri"

class Scraper
  include Scrapers::Carousel

  def initialize(file_path)
    @file = File.read(file_path)
    @document = Nokogiri::HTML(@file)
  end
end
