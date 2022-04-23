$LOAD_PATH << '.'

require 'Arts'
require 'Utils'

destination_path = './files/actual.json'
source_html_path = './files/van-gogh-paintings.html'

artworks = Arts::Artworks.new(source_html_path)

File.write(destination_path,artworks)
