require 'nokogiri'
require './parser'

file = File.open('files/van-gogh-paintings.html')
webpage_data = file.read
file.close

doc = Nokogiri::HTML(webpage_data)
parser = Parser.new(doc)
parser.parse
puts parser.parsed_data
