require_relative 'scraper.rb'

scraper = PaintingScraper.new('files/van-gogh-paintings.html')
scraper.parse_html