$LOAD_PATH << '.'

require 'Arts'
require 'Utils'

source_html_path = './files/van-gogh-paintings.html'
destination_path = './files/actual.json'
# source_html_path = './files/da-vinci-paintings.html'
# destination_path = './files/actual-da-vinci.json'


artworks = Arts::Artworks.new(source_html_path)

File.write(destination_path,artworks)
