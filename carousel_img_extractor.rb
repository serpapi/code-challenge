require "httparty" 
require "nokogiri"
require 'json'
require 'base64'

# Open and read the HTML file
file_path = './files/van-gogh-paintings.html'
html_content = File.read(file_path)

# Parse the HTML content
parsed_html = Nokogiri::HTML(html_content)

img_carousel = parsed_html.css('g-scrolling-carousel')
script_tags = parsed_html.css('script')

json_data = { "artworks" => [] }

# Iterates each item in the carousel
img_carousel.css('a').each do |ele|
    title = ele['aria-label'] ? ele['aria-label'] : next

    extensions = ele.css('.ellip.klmeta').map { |element| element.text }
    image_url = "https://www.google.com#{ele['href']}"
    image = ele.at_css('img')
    thumbnail = nil
    image_id = image['id']

    script_tags.each do |script|
        match = /var\s+s\s*=\s*'([^']+)';\s*var\s+ii\s*=\s*\[\s*'#{image_id}'\s*\];/.match(script.content)
        thumbnail = Base64.strict_encode64(Base64.decode64(match[1])) if match
    end      

    artwork_data = {
        "name": title,
        "extensions": extensions,
        "link": image_url,
        "image": thumbnail
    }
  
    json_data["artworks"] << artwork_data
end

# Writes data to JSON file
formatted_json = JSON.pretty_generate(json_data)
File.write('./img-extractor-output.json', formatted_json)
puts "Images extracted to img-extractor-output.json!"
