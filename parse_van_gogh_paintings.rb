require 'nokogiri'
require 'awesome_print'

def parse_html_file(file_path)
  html_file = File.open(file_path)
  Nokogiri::HTML(html_file)
end

van_gogh_paintings_html = parse_html_file('files/van-gogh-paintings.html')

def extract_artworks(html_doc)
  html_doc.search(".KHK6lb").map do |artwork|
    name = artwork.at_css(".pgNMRc").text.strip
    extensions = artwork.search(".cxzHyb").map { |extension| extension.text.strip }

    { "name" => name, "extensions" => extensions }
  end
end

artworks = extract_artworks(van_gogh_paintings_html)

result = { "artworks" => artworks }

ap result
