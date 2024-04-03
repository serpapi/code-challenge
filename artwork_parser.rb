require 'nokogiri'
require 'json'

class ArtworkParser
  def initialize(html_file)
    @html_file = html_file
  end

  def parse
    document = Nokogiri::HTML(File.open(@html_file))
    artworks = []

    artwork_divs = document.css("div.MiPcId.klitem-tr")

    artwork_divs.each do |div|
    puts div.at_css("div.kltat").text.strip
    name = div.at_css("div.kltat").text.strip
    year_element = div.at_css("div.klmeta")
    year = year_element ? year_element.text.strip : nil
    link = div.at_css("a")['href']
    image = div.at_css("img")['data-src']

    artworks << {
      "name" => name,
      "extensions" => year ? [year] : [],
      "link" => link,
      "image" => image
    }
    end

    File.open("artworks.json", "w") do |file|
      file.write(JSON.pretty_generate({ "artworks" => artworks }))

    artworks
    end
  end
end
