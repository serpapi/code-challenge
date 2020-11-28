#!/usr/bin/env ruby

require 'nokogiri'
require './lib/parser_worker'
require 'json'

class Parser
  def create
    h = {}
    doc = Nokogiri::HTML(File.open('./files/van-gogh-paintings.html').read)
    node = doc.css('.MiPcId')
    h[:artworks] = ParserWorker.new.process(node)
    File.write("./output.json", JSON.pretty_generate(h))
    JSON.generate(h)
  end
end

Parser.new.create
