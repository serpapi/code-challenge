require 'nokogiri'

class CarouselParser
	def initialize(html)
		@html = html
	end

	# Based on the layout type run a different parsing


	# Parser purpose:
	# Extract item name, extensions array (data), Google Link and thumbnails
	def parse
		doc = Nokogiri::HTML(@html)

		collection = {
			artworks: []
		}

		# Get the carousel
		carousel = doc.css("g-scrolling-carousel");
		# Get the carousel items
		items = carousel.css("a");

		puts items[0].css()

		items.each do |item|
			# Get the carousel description
			item_content = item.css('*:nth-child(2)');

			item_name = item_content.css('> *:nth-child(1)').text.strip
			item_extensions = item_content.css('> *:nth-child(2)').text.strip
			item_link = item["href"] ? "https://google.com#{item["href"]}" : nil
			item_image = item.css("img")[0] ? item.css("img")[0]["data-key"] : nil

			collection[:artworks] << {
				name: item_name,
				extensions: [item_extensions],
				link: item_link,
				image: item_image
			}
		end

		# puts collection[:artworks][0]

		# Return an array containing the extracted data
		collection
	end
end