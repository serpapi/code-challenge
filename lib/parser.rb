require "nokogiri"
require "json"

class Parser
  def initialize(html)
    @html = html
  end

  def parse
    doc = Nokogiri::HTML(@html)
    paintings = doc.css("#extabar g-scrolling-carousel div > div > div")

    artworks = paintings.map do |painting|
      content =  painting.css("a div:nth-child(2) div")
      extensions = content[1] ? [content[1].text] : []

      {
        name: content.first.text,
        extensions: extensions,
        link: "https://www.google.com#{ painting.css("a").first["href"] }",
        image: painting.css("g-img img").first["src"],
      }
    end

    {artworks: artworks}
  end

  def to_json
    parse.to_json
  end
end
