Bundler.require
require_relative 'lib/google_artworks_scraper.rb'

vangogh = GoogleArtworkScraper.new("files/van-gogh-paintings.html")
vangogh.scrape