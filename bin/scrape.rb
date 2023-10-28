require_relative "../services/carousel_scraper_service"
File.write("output.json", CarouselScraperService.new(input_file: ARGV[0]).call)
