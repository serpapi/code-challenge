require_relative 'lib/google_carousel_scraper'


g = GoogleCarouselScraper.new("../files/van-gogh-paintings.html")
g.extract()