# frozen_string_literal: true

require_relative "../scraper"
require "json"

begin
  # Check if a path to an HTML file is provided
  raise "Error: Missing input file. Please provide the path to an HTML file as an argument." unless ARGV[0]

  # Check if the provided file has a valid HTML extension
  unless File.extname(ARGV[0]) == ".html"
    raise "Error: Invalid file format. The input file must have a .html extension."
  end

  puts "Scraping process initiated for #{ARGV[0]}."
  results = Scraper.new(ARGV[0]).scrape_carousel

  puts "Generating JSON file..."
  json = JSON.pretty_generate({artworks: results})

  puts "Preparing results..."
  File.write("result.json", json.lines[0..-2].join.gsub("\n  ", "\n")[2..-2])

  puts "JSON output file generated: ./result.json"
  puts "Done"
rescue => e
  puts "Error: #{e.message}"
end
