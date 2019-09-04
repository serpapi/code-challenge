require 'bundler/setup'

require 'open-uri'
require 'nokogiri'

Artwork = Struct.new(:name, :image, :link, :extensions, keyword_init: true)

class Parser
  def parse
    url = './files/van-gogh-paintings.html'
    html = open(url)

    doc = Nokogiri::HTML(html)

    artworks = doc.css('.klitem').map do |painting|
      artwork = Artwork.new(
        name: painting.at_css('.kltat').content,
        image: painting.at_css('img') ? painting.at_css('img').attr('src') : nil,
        link: painting.attr('href'),
      )

      artwork[:extensions] = [ painting.at_css('.klmeta').text ] if painting.at_css('.klmeta')

      artwork
    end

    result = { artworks: artworks }
  end
end