# frozen_string_literal: true
require 'json'

result_file = File.expand_path('files/valid-expected-array.json', File.dirname(__FILE__))
expected_result_file = File.read(result_file)
expected_results = JSON.parse(expected_result_file)

generated_file = File.expand_path('generated-result.json', File.dirname(__FILE__))
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

puts "Results"
puts "#{matches.count} matching:"
puts matches.join(', ')
puts "#{not_matching.count} not matching:"
puts not_matching.join(', ')