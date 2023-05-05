# Call nokogiri
require 'nokogiri'
require 'CSV'

document = Nokogiri::HTML(open('files/van-gogh-paintings.html').read, nil, 'utf-8');

IndividualItem = Struct.new(:title, :date, :data_source, :image, :url)

individual_carousel_items = []

# Target the top-level [div] that contains all children carousel items
carousel_items = document.css("g-scrolling-carousel div.klitem-tr")

# Iterating over the list of carousel items
carousel_items.each do |carousel_item|

    # Extracting the data (title, date, data-src, image, url)
    title = carousel_item.css("div.kltat span").text
    date = carousel_item.css("div.klmeta").text
    data_src = carousel_item.css("img").map { |data| data['data-src'] }
    image = carousel_item.css("img").map { |image| image['src'] }
    url = carousel_item.at_css("a.klitem").attr("href")

    # Cycle through and update each parameter accordingly for individual items
    individual_carousel_item = IndividualItem.new(title, date, data_src, image, url)

    # Push those changes up stream to the parent (individual_carousel_items)
    individual_carousel_items.push(individual_carousel_item) 

    # Very basic [shell] based output (if preferred)
    # puts "TITLE: " + "\n    " + title + " (" + date + ")"
    # puts ""
    # puts "IMAGE DATA SOURCE: " + "\n    " + image.to_s
    # puts ""
    # puts "LINK URL: " + "\n    https://google.com" + url
    # puts ""
    # puts "-----------------------------------------------------"
    # puts ""
end

## Export evrything into a simple CSV
csv_headers = ["title", "date", "data-src", "image", "url"]
CSV.open("output.csv", "wb", write_headers: true, headers: csv_headers) do |csv|
    individual_carousel_items.each do |individual_carousel_item|
        csv << individual_carousel_item
    end
end
