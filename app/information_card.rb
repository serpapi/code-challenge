class InformationCard

	def initialize(html)
		@html_element = html
	end

	def to_h
		{
			name: name,
			extensions: extensions,
			link: link,
			image: image
		}
	end

	def name
		@html_element['aria-label']
	end

	def extensions
		@html_element['title'].scan(/\d{4}/)
	end

	def link
		# TODO: add xpath of link code
	end

	def image
		@html_element.children.css('img').first['src']
	end
	
end