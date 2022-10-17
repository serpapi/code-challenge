#!/usr/bin/env ruby

require_relative 'app/scrape_content'


html_file_path = ARGV[0] || 'files/van-gogh-paintings.html'
puts "\nScraping Data from target\n"
output_path = ScrapeContent.new(file_path: html_file_path).call
puts "\nData scraped successfully!\n"
puts "\nData can be viewed at: #{File.expand_path(output_path)}" 
