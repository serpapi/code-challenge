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

def add_thumbnails_into_array(html_doc, array)
  # TODO: Implement logic for thumbnails with an id

  # For the thumbnails that don't have an id (i.e. that aren't displayed on the SERP)
  thumbnails = html_doc.search(".taFZJe").each_with_object({}) do |thumbnail, hash|
    data_src = thumbnail.attr("data-src")
    name = thumbnail.attr("alt")
    hash[name] = data_src  # Pair the name and data_src like this for when we add thumbnails to the array
  end

  array.each do |el|
    thumbnail = thumbnails[el["name"]]
    el["image"] = thumbnail
  end
end

add_thumbnails_into_array(van_gogh_paintings_html, artworks)

result = { "artworks" => artworks }

ap result
