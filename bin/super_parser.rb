require './lib/scraper'

path = "file://#{__dir__}/../files/van-gogh-paintings.html"

@scraper = Scraper::SuperParser.new(path)
pp @scraper.artworks
