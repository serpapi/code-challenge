require 'bundler/setup'

require 'nokogiri'

Artwork = Struct.new(:name, :link, :image, :extensions, keyword_init: true)

class ArtworksParser
  def parse
    url = './files/van-gogh-paintings.html'
    html = File.open(url).read

    doc = Nokogiri::HTML(html)

    images = html.scan(/var s='(data:image\/jpeg;base64,\S+)';/).map { |image| image[0] }

    artworks = doc.css('.klitem').each_with_index.map do |painting, index|
      link = "https://www.google.com#{painting.attr('href')}"

      extensions = painting.at_css('.klmeta') ? [ painting.at_css('.klmeta').text ] : nil
      
      image = images[index] || nil
      
      Artwork.new(
        name: painting.at_css('.kltat').content,
        link: link,
        image: image,
        extensions: extensions
      )
    end

    result = { artworks: artworks }
  end
end
