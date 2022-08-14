require 'nokogiri'

art_works = Hash.new

art_works["artworks"] = []

html = File.open("van-gogh-paintings.html").read

parsed_data = Nokogiri::HTML(html)


images_thumbnails = html.scan(/var s='(data:image\/jpeg;base64,\S+)';/).map { |image| image[0] }

parsed_data.css('.klitem').each_with_index.map do |art_work, index|
  item_hash = Hash.new

  item_hash["name"] = art_work.at_css('.kltat').content ? art_work.at_css('.kltat').content : "" 

  item_hash["extensions"] = art_work.at_css('.klmeta') ? [art_work.at_css('.klmeta').text] : nil

  item_hash["link"] = "https://www.google.com#{art_work.attr('href')}"

  item_hash["image"] = images_thumbnails[index] || nil

  art_works["artworks"].push(item_hash)
end

puts art_works
