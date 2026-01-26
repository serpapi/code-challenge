require_relative 'lib/carousel_scraper'
require 'json'

file = ARGV[0] || 'files/van-gogh-paintings.html'

html = File.read(file)
scraper = CarouselScraper.new(html)
result = scraper.extract

output_file = file.sub('.html', '-expected-array.json')
File.write(output_file, JSON.pretty_generate(result))

puts "Expected array available in #{output_file}"
