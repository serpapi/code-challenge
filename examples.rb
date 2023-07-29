require './lib/scrapers/google_search'

search = GoogleSearch.new(q: 'van gogh')
artworks = search.get_artworks(formatted: true)

File.write("output/artworks-van-gogh.json", artworks)

search = GoogleSearch.new(q: 'monet')
artworks = search.get_artworks(formatted: true)

File.write("output/artworks-monet.json", artworks)

search = GoogleSearch.new(q: 'caravaggio')
artworks = search.get_artworks(formatted: true)

File.write("output/artworks-caravaggio.json", artworks)