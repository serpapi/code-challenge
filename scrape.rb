require 'concurrent'
require 'nokogiri'
require 'httparty'

def replace_equals_with_x3d(str)
	idx = str.length - 1
	while str[idx] == '='
		str[idx] = 'x3d'
		idx -= 1
	end
	str
end

def get_artworks_from_html(content)
    data = {}
    
    doc = Nokogiri::HTML(content)
    links = doc.css('.klitem')

    promises = links.map do |link|
        Concurrent::Promises.future do
            res = {}

            res['name'] = link.attribute('aria-label').text
            res['link'] = 'https://www.google.com' + link.attribute('href').text
            extensions = link.css('div.ellip.klmeta').map { |d| d.text}
            res['extensions'] = extensions unless extensions.empty?
            url = link.at('img').attribute('data-key')&.text
            res['image'] = nil
            if url
                response = HTTParty.get(url)
                if response.code == 200
                    base64_image = Base64.strict_encode64(response.body)
                    base64_image = "data:image/jpeg;base64,#{base64_image}"
                    # not sure if this is needed
                    # I'm adding this because expected image ends with 'x3d'
                    res['image'] = replace_equals_with_x3d(base64_image)
                end
            end
            res
        end
    end

    data['artworks'] = Concurrent::Promises.zip(*promises).value
        
    return data
end

content = File.open('./files/van-gogh-paintings.html')
pp get_artworks_from_html(content)
