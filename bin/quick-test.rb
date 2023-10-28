#! /home/leo/.rvm/rubies/ruby-3.2.2/bin/ruby
require_relative "../services/carousel_scraper_service"
File.write("output.json", CarouselScraperService.new(input_file: ARGV[0]).call)
