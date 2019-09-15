#!/usr/bin/env ruby

require_relative "lib/image_results"

file_name = ARGV[0] ||
  File.join(File.dirname(__FILE__), "files/van-gogh-paintings.html")

file_name = File.expand_path(file_name)

results = ImageResults.new(file_name)
puts JSON.pretty_generate(results.as_json)
