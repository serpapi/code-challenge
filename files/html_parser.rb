require 'nokogiri'
require 'json'

# Load the HTML file
html_file = File.open('van-gogh-paintings.html')
doc = Nokogiri::HTML(html_file)

# Initialize an array to store the paintings
paintings = []

# Extract paintings from the HTML
doc.css('div.yrF3V').each do |painting|
  name = painting.css('div.BNeawe.vvjwJb.AP7Wnd').text
  extensions = painting.css('span.BNeawe.s3v9rd.AP7Wnd').text.split(',').map(&:strip)
  link = painting.css('a')[0]['href']
  image_data = painting.css('img')[0]['src']

  paintings << {
      "name" => name,
      "extensions" => extensions,
      "link" => link,
      "image" => image_data
  }
end

# Create a JSON object containing the paintings array
output = { "artworks" => paintings }

# Save the JSON to a file
File.open('output.json', 'w') do |file|
  file.write(JSON.pretty_generate(output))
end

puts "Output saved to output.json"
