# frozen_string_literal: true

require 'json'
require_relative 'modules/generic_google_parser'

path = ARGV[0] or abort 'usage: ruby use_generic_google_parser.rb path/to/filename.html'
html = File.read(path)

google_parser = GenericGoogleParser.new

puts JSON.pretty_generate(JSON.parse(google_parser.parse(html)))
