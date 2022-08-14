require 'nokogiri'

art_works = Hash.new

art_works["artworks"] = []

parsed_data = File.open("van-gogh-paintings.html") { |f| Nokogiri::HTML5(f) }

parsed_data.css('.klitem').each do |art_work|
  item_hash = Hash.new

  item_hash["name"] = art_work.at_css('.kltat').content ? art_work.at_css('.kltat').content : "" 

  item_hash["extensions"] = art_work.at_css('.klmeta') ? [art_work.at_css('.klmeta').text] : nil

  item_hash["link"] = "https://www.google.com#{link.attr('href')}"

  art_works["artworks"].push(item_hash)
end

puts art_works
