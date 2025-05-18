#! /usr/bin/env ruby

require 'nokogiri'
require 'json'
require_relative 'lib/parser'

if __FILE__ == $0
    parser = Parser.new(ARGV[0])
    parser.extract_carousel()
    parser.write_json(ARGV.length > 1 ? ARGV[1] : ARGV[0].gsub(/.html/, '.json'))
end