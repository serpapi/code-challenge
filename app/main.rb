# frozen_string_literal: true

require_relative 'extractor'

extractor = Extractor.new
extractor.extract

begin
  File.write('results/data.json', extractor.to_json)
  p 'Results were successfully written to results/data.json.'
rescue StandardError => e
  p "An error occurred: #{ e.message }"
end
