require 'nokogiri'

output_hash = Hash.new

output_hash["artworks"] = []

parsed_data = File.open("van-gogh-paintings.html") { |f| Nokogiri::HTML5(f) }

parsed_data.css('.klitem').each do |link|
  item_hash = Hash.new

  item_hash["name"] = link.at_css('.kltat').content ? link.at_css('.kltat').content : "" 

  item_hash["extensions"] = link.at_css('.klmeta') ? [link.at_css('.klmeta').text] : nil

  item_hash["link"] = "https://www.google.com#{link.attr('href')}"

  output_hash["artworks"].push(item_hash)
end

puts output_hash
