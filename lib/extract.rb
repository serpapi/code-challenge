require 'nokogiri'
require 'json'

def extract(html_string)
	parsed = Nokogiri::HTML.parse(html_string) 
	# the preview image base64s are embedded in js, extract them!, key is id value is the image base64
	image_base64s = {}
	if true
		image_base64s_js = nil
		parsed.css("script").each do |possible_image_js|
			script_text = possible_image_js.inner_html
			if script_text.include? "_setImagesSrc"
				image_base64s_js = script_text
				scanned = image_base64s_js.scan(/'(data:image\/jpeg;base64,\S+)';\s*var ii\s*=\s*\['([a-z0-9_A-Z]*)'\]/)

				scanned.each do |result|
					subbed = result[0].gsub('\\','') # something funky
					image_base64s[result[1]] = subbed
				end			
			end
		end
	end

	artworks = []
	items_iter = parsed.css(".klitem")

	if items_iter.length == 0
		# other style of search result, this detection could be much better!
		items_iter = parsed.xpath("//div[@data-entityname]")
	
		items_iter.each do |elem_name_element|
			elem = elem_name_element.parent.parent.parent
			if elem.attributes.key?("class") and elem.attributes["class"].to_str == "sinMW"
				new_artwork = {}
				new_artwork["name"] = elem_name_element.attr("data-entityname")
				links = elem.css("a")
				if links.length > 0
					new_artwork["link"] = links[0].attr('href')
				else
					new_artwork["link"] = nil
				end
				image_id = elem.css("img")[0].attr('id')
				new_artwork["image"] = image_base64s[image_id]
			
				artworks.append(new_artwork)
			end
		end

			else
		items_iter.each do |painting|
			#puts painting.search("//text()").map { |item| item.to_s.length > 50 ? nil : item.text }
			#puts painting.inner_html
			attributes = painting.attributes
			if attributes.key?("title") and attributes.key?("href")
				new_artwork = {}
	
				new_artwork["name"] = attributes["aria-label"].value
				new_artwork["extensions"] = []
				painting.css(".ellip").each do |possible_ext|
					new_artwork["extensions"].append(possible_ext.inner_html)
				end
				if new_artwork["extensions"].empty?
					new_artwork.delete("extensions")
				end
				new_artwork["link"] = "https://www.google.com" + attributes["href"].value
	
				image_elem = painting.css("img")[0]
				new_artwork["image"] = image_base64s[image_elem.attr('id')]
	
				artworks.append(new_artwork)
			end
		end
	end
	return artworks
end


