#!/usr/bin/env ruby

require 'nokogiri'
require 'json'

class Parser
  def create
    h = {}
    doc = Nokogiri::HTML(File.open('./files/van-gogh-paintings.html').read)
    node = doc.css('.MiPcId')
    h[:artworks] = ParserWorker.new.process(node)
    JSON.pretty_generate(h)
  end
end

class ParserWorker
  def process(node)
    node.map do |n|
      parse(n)
    end
  end

  def parse(n)
    result = {}

    # name
    k = n.css('.klitem').first
    result[:name] = k['aria-label']

    # extensions
    year = n.css('.klmeta').text
    ext = { :extensions => [year] }
    result.merge!(ext) unless ext[:extensions].first.empty?

    # image
    result[:image] = n.css('div.klic > g-img > img')[0]['src']

    # link
    k = n.css('.klitem').first
    result[:link] = "https://www.google.com#{k['href']}"

    result
  end
end

Parser.new.create
