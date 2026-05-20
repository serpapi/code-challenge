# frozen_string_literal: true

require_relative 'lib/google_artist_page'

Dir.mkdir('tmp') unless File.directory?('tmp')

van_gogh_page = GoogleArtistPage.new('files/van-gogh-paintings.html')
michelangelo_page = GoogleArtistPage.new('files/michelangelo-art.html')
alabama_shakes_page = GoogleArtistPage.new('files/alabama-shakes-albums.html')
frank_lloyd_wright_page = GoogleArtistPage.new('files/frank-lloyd-wright-buildings.html')

File.write('tmp/scraped_artwork_van_gogh.json', van_gogh_page.artworks_json)
File.write('tmp/scraped_artwork_michelangelo.json', michelangelo_page.artworks_json)
File.write('tmp/scraped_artwork_alabama_shakes.json', alabama_shakes_page.artworks_json)
File.write('tmp/scraped_artwork_frank_lloyd_wright.json', frank_lloyd_wright_page.artworks_json)
