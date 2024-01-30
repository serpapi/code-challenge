require "nokogiri"
require "json"

def parse_carousel(file)
	host = "https://www.google.com"
	html = Nokogiri.HTML5(file)
	carousel = html.css("g-scrolling-carousel").first
	items = carousel.css(".klitem")
	images = []

	items.each do |item|
		hash = {}
		hash["name"] = item.attribute("aria-label").value
		hash["extensions"] = item.css(".klmeta").map(&:text)
		hash["link"] = "#{host}#{item.attribute('href')}"
		hash["img"] = item.css("img").attribute("src")&.value

		images.push(hash)
	end

	return JSON.pretty_generate({
		"artworks": images
	})
end

def resolve_path(name, extension)
	return File.expand_path(
		File.join(
			File.dirname(__FILE__), "files/#{name}.#{extension}"
		)
	)
end

def get_html(name)
	path = resolve_path(name, "html")
	return File.read(path)
end

def write_json(name, json)
	path = resolve_path(name, "json")
	File.write(path, json)
end

def run
	filename = "van-gogh-paintings"
	json = parse_carousel(
		get_html(filename)
	)
	write_json(filename, json)
end

run