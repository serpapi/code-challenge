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
		@html_element['href'].include?('www.google.com') ?  @html_element['href'] : "https://www.google.com" + @html_element['href']
	end

	def image
		@html_element.children.css('img').first['src']
	end
	
end