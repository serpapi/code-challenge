Bundler.require
require_relative 'lib/scraper.rb'

vangogh = Scraper.new("files/van-gogh-paintings.html")
vangogh.scrape