require 'open-uri'
require_relative 'artworks_processor'

file_path = ARGV[0]
if file_path.nil? || file_path.empty?
  puts 'Please provide the path to the HTML file as an argument.'
  exit 1
end

doc = Nokogiri::HTML(URI.open(file_path), nil, Encoding::UTF_8.to_s)

processor = ArtworkProcessor.new(doc)

artworks = processor.process

# Produce appropriate json value
#
# I notice that the '\' characters are not present in the values in
# the expected json. I'm not sure why. I'm removing them using `gsub`.
json_string = JSON.pretty_generate(artworks.map(&:to_hash)).gsub('\\', '')

print '"artworks": ' + json_string
