require 'nokogiri'
require 'json'

# Get the input HTML file path from command line arguments if van-gogh-paintings.html is not available
input_file_path = 'van-gogh-paintings.html'

unless File.exist?(input_file_path)
  puts "The 'van-gogh-paintings.html' file is not found. Please provide a valid input HTML file path:"
  input_file_path = gets.chomp

  unless File.exist?(input_file_path)
    puts "The specified input HTML file does not exist. Exiting."
    exit
  end
end

# Load the HTML file
html_file = File.open(input_file_path)
doc = Nokogiri::HTML(html_file)

# Initialize an array to store the paintings
paintings = []

# Define the mapping of fields to their extraction methods
field_mapping = {
  "name" => ->(element) { element.css('h2').text },
  "extensions" => ->(element) { element.css('p.date').text.split(',').map(&:strip) },
  "link" => ->(element) { element.css('a').first['href'] },
  "image" => ->(element) { element.css('img').first['src'] }
}

# Extract paintings from the HTML
doc.css('div.painting').each do |element|
  painting = {}

  field_mapping.each do |field, extraction_method|
    painting[field] = extraction_method.call(element)
  end

  paintings << painting
end

# Create a JSON object containing the paintings array
output = { "artworks" => paintings }

# Generate the output file name based on the input file name
output_file_path = input_file_path.gsub('.html', '_output.json')

# Save the JSON to a file
File.open(output_file_path, 'w') do |file|
  file.write(JSON.pretty_generate(output))
end

puts "Output saved to #{output_file_path}"
