# frozen_string_literal: true

require 'json'
require_relative './challenge/challenge'

filenames = %w[
  van-gogh-paintings.html
  game_of_thrones_cast.html
  christopher_tokien_books.html
  george_w_bush_google_search.html
]

filenames.each do |fname|
  in_path = File.expand_path("files/#{fname}")

  output_file_name = fname.sub('.html', '.json')
  out_path = File.expand_path("output/#{output_file_name}")

  puts "\nParsing file #{in_path}"
  document = Challenge::HtmlFileParser.new(in_path).parse
  result = Challenge::Parser.new(document).parse

  puts "writing results to #{out_path}"
  File.write(out_path, JSON.dump(result))
end
