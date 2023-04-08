require_relative 'artwork_scraper'

scraper = ArtworkScraper.new
scraper.run(ARGV)