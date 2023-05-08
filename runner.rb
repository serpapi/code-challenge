# frozen_string_literal: true

require_relative "./lib/google_scraper"

file_to_scrape = ARGV.first || "files/van-gogh-paintings.html"
puts GoogleScraper.new(file_to_scrape).scrape
