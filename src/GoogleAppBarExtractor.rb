require 'nokogiri'
require 'json'

class GoogleAppBarExtractor

  def extractCards(html)
	html_dom = Nokogiri::HTML.parse(html)

	blocks = html_dom.css('.klitem')


	results = Array.new(blocks.size) {}


	blocks.each_with_index do |block, index|
		name = block.css('.kltat')[0].content
		extensions = Array.new
		block.css('.ellip.klmeta').each do |extension|
			extensions.append(extension.content)
		end

		
		img_id = block.css('img')[0]['id']
		re = /var s='([0-9a-zA-Z:,;+\/\\]*)';var ii=\['#{img_id}'\]/im
		img = nil
		matche = html.match(re);

		if !matche.kind_of?(NilClass)
			img = matche[1].gsub("\\x3d", "=")
		end
		results[index] = {name: name, extensions: extensions, link: "https://www.google.com" + block["href"], image: img}
	end

	return results
  end

end