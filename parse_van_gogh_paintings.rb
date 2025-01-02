require 'nokogiri'
require 'awesome_print'

def parse_html_file(file_path)
  html_file = File.open(file_path)
  Nokogiri::HTML(html_file)
end

def extract_artworks(html_doc)
  html_doc.search(".iELo6 a").map do |artwork|
    name = artwork.at_css(".pgNMRc").text.strip

    extensions = artwork.search(".cxzHyb").map { |extension| extension.text.strip }
    extensions = nil if extensions.all?(&:empty?)

    link = "https://www.google.com" + artwork.attr("href")

    { "name" => name, "extensions" => extensions, "link" => link }
  end
end

def add_thumbnails_into_array(html_doc, array)
  thumbnails = html_doc.search(".taFZJe").each_with_object({}) do |thumbnail, hash|
    name = thumbnail.attr("alt")
    id = thumbnail.attr("id")
    data_src = thumbnail.attr("data-src") # For the thumbnails that don't have an id (i.e. that aren't displayed on the SERP)

    if id
      html_doc.css('script').each do |script|
        script_content = script.content

        if script_content.include?("var ii=['#{id}']") # The image string exists in the script, just before the artwork's id
          match = script_content.match(/var s='(.*?)';/) # Extract the image string from within `s=''`
          unclean_image_string = match[1] if match
          image_string = unclean_image_string.gsub("\\x3d", "=") # This deals with an escaped character issue - if I had more time I'd consider using a wider encompassing approach
          hash[name] = image_string # Pair with the name like this for when we add thumbnails to the array
        end
      end
    else
      hash[name] = data_src # Pair with the name like this for when we add thumbnails to the array
    end

    # TODO: Refactor the above so that `hash[name]` assignment adheres to DRY principle
    # The challenge I think I'm facing is that `script_content` gets returned when `id` is truthy (that might be wrong though)
    # Want to prioritize other features as this is technically working
  end

  array.each do |el|
    thumbnail = thumbnails[el["name"]]
    el["image"] = thumbnail
  end
end

def parse_van_gogh_paintings(file_path)
  html_doc = parse_html_file(file_path)
  artworks = extract_artworks(html_doc)
  add_thumbnails_into_array(html_doc, artworks)

  artworks
end

parse_van_gogh_paintings('files/van-gogh-paintings.html')
