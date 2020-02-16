# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'json'
require_relative 'file_parser'

def parse_from_file(file_path)
  file_parser = FileParser.new File.read(file_path)
  result = file_parser.parse
  puts JSON.pretty_generate(result)
end

def main
  if ARGV.empty?
    puts 'Tips: use ruby main.rb file_name.html'
    exit 1
  end
  parse_from_file ARGV[0].to_str
  nil
end

main
