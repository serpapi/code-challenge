require 'awesome_print'
require_relative 'lib/scraper'


puts "Enter which page you want to scrape:\n 1. Van Gogh\n 2. Tom Cruise\n 3. Tina Fey\n exit to exit"

while (choice = gets.chomp) != 'exit'
  if choice == '1'
    ap Scraper.new.scrape
    break
  elsif choice == '2'
    ap Scraper.new('files/tom-cruise.html').scrape
    break
  elsif choice == '3'
    ap Scraper.new('files/tina-fey.html').scrape
    break
  end
end
