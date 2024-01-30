require "nokogiri"
require "json"

def get_encoded_images(html)
	images = {}
	html.inner_html.scan(/_setImagesSrc.+?var s=\'(.*?)\'.*?var ii=\[\'(.*?)\'/) do |source, id|
		images[id] = source.gsub("\\", "")
	end
	return images
end

def parse_artworks(file)
	host = "https://www.google.com"
	html = Nokogiri.HTML5(file)
	encoded_images = get_encoded_images(html)
	artworks = html.css(
		"[data-attrid='kc:/visual_art/visual_artist:works']"
	).first
	items = artworks.css("a")
	images = []

	items.each do |item|
		hash = {}
		hash["name"] = item.css("img").attribute("alt").text
		hash["extensions"] = item.css("div:first-child+div").map(&:text)
		hash["link"] = "#{host}#{item.attribute('href')}"
		hash["image"] = encoded_images[item.css("img").attribute("id")&.value]

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

def run(filename)
	json = parse_artworks(
		get_html(filename)
	)
	write_json(filename, json)
end

run("alt-van-gogh-paintings")
run("alt-picasso-paintings")
run("alt-la-tour-paintings")