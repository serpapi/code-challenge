require 'nokogiri'
# require 'byebug' # Uncomment to interact with solution from terminal
require 'json'

def scraper
    url = "../files/van-gogh-paintings.html"
    unparsed_page = File.read(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    gallery = parsed_page.css("div > a.klitem")
    first_item = parsed_page.css("div > a.klitem").first
    photos = []

    gallery.each do |photo_item|
        item_summary = photo_item.text
        photo_name = ""
        photo_year = ""
        address = photo_item.attributes["href"]
        image_src = photo_item.css('img.rISBZc.M4dUYb')[0].attributes["src"]
        image_link = ""

        if address != nil
            address = "https://www.google.com" + address.value

        else address = "Missing link property"
        end

        if item_summary != nil
            photo_name = item_summary.slice(...-4)
            photo_year = item_summary.slice(-4...)

        else photo_name = "Missing name value"
            photo_year = "Missing name value"
        end

        if image_src != nil
            image_link = image_src.value

        else image_link = "Missing image property"
        end

        photo_item = {
            name: photo_name,
            extensions: [
                photo_year
            ],
            link: address,
            image: image_link
        }

        photos << photo_item
    end

    File.open("results/van-gogh-paintings.json", "w") do |f|
        # f.write(JSON.pretty_generate("artworks": photos)) # Better formatted JSON

        f.write('"artworks": ', JSON.pretty_generate(photos)) # Suggested JSON from solution sample
    end

    # Uncomment "byebug" to interract with solution from terminal
    # byebug
end

scraper
