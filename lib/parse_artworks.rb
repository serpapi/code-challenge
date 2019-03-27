require 'oga'

class ParseArtworks
  attr_reader :document
  attr_reader :response

  def initialize document, response
    @document = document
    @response = response
  end

  def self.parse response
    return self.new(Oga.parse_html(response), response)
  end

  def images
    re = /var s\='data:image\/jpeg;base64,([a-zA-Z0-9+\/\\]+)?';/
    images = response.scan(re)
  end
  
  def artworks
    artworks = document.css(".klitem-tr .klitem").each_with_index.map do |e, i|
      image = nil
      if !images[i].nil?
        image = "data:image/jpeg;base64," + images[i].shift.delete('\\')
      end
      { 
        :name => e.css(".kltat").text,
        :extensions => [
          e.css(".klmeta").text
        ],
        :link => "https://www.google.com" + e.attribute("href").to_s,
        :image => image
      }
    end
  end
end