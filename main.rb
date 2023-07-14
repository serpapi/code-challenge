require 'nokogiri'
require_relative './parser'

fname = 'files/van-gogh-paintings.html'

html = File.read(fname)
doc = Nokogiri::HTML html
result = Parser.new(doc).parse

pp result
