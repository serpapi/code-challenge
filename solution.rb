require 'nokogiri'
require 'json'

module GoogleArtworkCarouselParsing
  def self.parse(filename)
    doc = get_html_document(filename)

    artwork = []
    doc.css("div.iELo6").each do |entry_data|
      artwork << read_artwork_entry(doc, entry_data)
    end

    artwork
  end

  private

  def self.get_html_document(filename)
    f = File.read(filename)
    doc = Nokogiri::HTML5(f)
  end

  def self.read_artwork_entry(doc, entry_data)
    entry_format_regex = /<div class="iELo6" .*><a href="(.*)"><img class="taFZJe" alt="(.*?)" (.*)<div class="pgNMRc">(.*)<\/div><div class="cxzHyb">(.*)<\/div><\/div><\/a><\/div>/
    parsed_entry = entry_data.to_s.scan(entry_format_regex)[0]
    entry_details = {}
    entry_details[:name] = parsed_entry[1]
    entry_details[:extensions] = [parsed_entry[4]] if (parsed_entry.length == 5 && parsed_entry[4].length > 0)
    entry_details[:link] = "https://www.google.com" + parsed_entry[0].gsub("&amp;", "&")

    image_info = parsed_entry[2]
    entry_details[:image] = if image_info.start_with? "id="
                              self.read_image_through_id(doc, image_info)
                            else
                              self.read_image_through_data_src(doc, image_info)
                            end

    entry_details
  end

  def self.read_image_through_id(doc, image_info)
    id_results = image_info.scan(/id="(.*?)"/)[0][0]
    image_id_format_regex = /<script nonce=".*?">\(function\(\){var s='([^']*?)';var ii=\['#{id_results}'\]/
    doc.to_s.scan(image_id_format_regex)[-1][0]
  end

  def self.read_image_through_data_src(doc, image_info)
    image_info.scan(/data-src="(.*?)"/)[0][0]
  end

end


