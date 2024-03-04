Bundler.require
require_relative 'lib/google_artwork_scraper.rb'

if ARGV.empty?
  puts "You didnt include an HTML file to scrape"
  puts "Try again with `bundle exec ruby scrape.rb path/to/file.html`"
  exit 1
end

filepath = ARGV[0]
extension = File.extname(filepath).downcase

if !File.exists?(filepath)
  puts "Error: File '#{filepath}' not found."
  exit 1
elsif extension != ".html"
  puts "Error: File '#{filepath}' is not an HTML file."
  exit 1
else
  GoogleArtworkScraper.new(filepath).scrape_to_file
end