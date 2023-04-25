require 'open-uri'
require 'nokogiri'

class Scrapper
  def initialize(path)
    @path = path
  end

  def carrousel_json
    html = URI.open(@path).read

    doc = Nokogiri::HTML(html)
    carrousel_tab = doc.css('#botabar')

    carrousel_json = carrousel_tab.css('a').map do | link |
      unless link[:href].nil?
        {
          name: link.text.scan(/\D+/).join,
          extensions: link.text.scan(/\d+/),
          link: "https://www.google.com#{link[:href]}",
          image: link.css('img').first[:src]
        }
      end
    end
    
    carrousel_json.compact
  end
end
