# frozen_string_literal: true

require_relative 'modules/naive_parser'

html = File.read('spec/fixtures/2024/van-gogh-paintings.html')

parser = NaiveParser.new

puts parser.parse(html)
