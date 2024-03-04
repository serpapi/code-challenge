Bundler.require
require_relative 'lib/google_artwork_scraper.rb'

vangogh = GoogleArtworkScraper.new("files/van-gogh-paintings.html")
vangogh.scrape_to_file

botticelli = GoogleArtworkScraper.new("files/botticelli-paintings.html")
botticelli.scrape_to_file
