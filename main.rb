# frozen_string_literal: true

require_relative 'lib/paintings_parser'
require 'json'

html = File.read('files/van-gogh-paintings.html')
parser = PaintingsParser.new(html)
results = parser.parse

puts JSON.pretty_generate(results)

File.write('output.json', JSON.pretty_generate(results))
puts "\nResults saved to output.json!"
