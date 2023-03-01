# frozen_string_literal: true
require 'json'
require_relative 'runner'

# Constants for file paths
FILE_PATH = File.expand_path('files/van-gogh-paintings.html', File.dirname(__FILE__))
FILE_URL = "file:///#{FILE_PATH}"
OUTPUT_FILE_PATH = File.expand_path('generated-result.json', File.dirname(__FILE__))

# Actual test code
result_file = File.expand_path('files/valid-expected-array.json', File.dirname(__FILE__))
expected_result_file = File.read(result_file)
expected_results = JSON.parse(expected_result_file)

generated_file = File.expand_path('generated-result.json', File.dirname(__FILE__))
if File.exist?(generated_file)
  puts "Detected previous generated-result.json, deleting it and re-running the script"
  File.delete(generated_file)
end

# Generates new result file
Runner.new(FILE_URL, OUTPUT_FILE_PATH).run

generated_result_file = File.read(generated_file)
generated_results = JSON.parse(generated_result_file)

pairs = expected_results['artworks'].zip(generated_results['artworks'])

matches = []
not_matching = []

pairs.each do |expected, generated|
  if expected == generated
    matches << expected['name']
  else
    not_matching << expected['name']
  end
end

# Debug code
# expected, generated = pairs[0]
# expected == generated
# require 'pry-byebug'
# binding.pry

puts "Results"
puts "#{matches.count} matching:"
puts matches.join(', ')
puts "#{not_matching.count} not matching:"
puts not_matching.join(', ')
