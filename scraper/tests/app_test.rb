require 'nokogiri'
require 'json'
require 'rspec/autorun'

def scraper
    url = "../../files/van-gogh-paintings.html"
    unparsed_page = File.read(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    gallery = parsed_page.css("div > a.klitem")
    first_item = parsed_page.css("div > a.klitem").first
    photos = Array.new

    describe "Check url" do
        it 'path has "/van-gogh-paintings.html"' do
            expect(url).to include("/van-gogh-paintings.html")
        end
    end

    gallery.each_with_index do |photo_item, index|
        index += 1
        address = photo_item.attributes["href"]
        image_src = photo_item.css('img.rISBZc.M4dUYb')[0].attributes["src"]
        image_link = image_src
        item_summary = photo_item.text
        photo_name = item_summary.slice(...-4)
        photo_year = item_summary.slice(-4...)

        # puts "Checking artwork #{index} details"

        describe "Collection has" do
            # it 'Description value' do
            #     expect(item_summary).not_to eql(nil)
            # end

            # it 'Name value' do
            #     expect(photo_name).not_to eql(nil)
            # end

            # it 'Extensions value' do
            #     expect(photo_year).not_to eql(nil)
            # end

            # it 'Link value' do
            #     expect(address).not_to eql(nil)
            # end

            # it 'Image value' do
            #     expect(image_link.value).not_to eql(nil)
            # end

            {
                description: item_summary,
                name: photo_name,
                extensions: photo_year,
                link: address,
                # image: image_link.value
                image: image_link
            }.each do |attribute, type|
                it "Has #{attribute.capitalize}" do
                    expect(type).not_to eql(nil)
                end
            end
        end

        # puts "Artwork #{index} checks completed"

        photos << photo_item
    end

    File.open("../results/van-gogh-paintings.json", "w") do |f|
        f.write('"artworks": ', JSON.pretty_generate(photos))
    end
end

scraper
