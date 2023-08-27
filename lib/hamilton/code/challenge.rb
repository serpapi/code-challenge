# frozen_string_literal: true

require 'nokogiri'
require 'json'

module Challenge  
  def self.parse(e)
    result = {}    
    result[:name] = e.child.attribute_nodes.select {|a| a.name == "aria-label"}[0].value
    
    
    extensions = []
    meta = e.css(".klmeta").first
    if (meta)
      meta.children.each {|c| extensions.push(c.to_s)}
      result[:extensions] = extensions
    end    
    
    result[:link] = "https://google.com" + e.child.attribute_nodes.select {|a| a.name == "href"}[0].value
    
    imageElement = nil
    imageElement = e.css("//g-img").first.children.first.attribute_nodes.select {|a| a.name == "src"}[0]    
    if (imageElement)
      result[:image] = imageElement.value
    else
      result[:image] = nil
    end

    return result
  end
  class Error < StandardError; end
  finalArray = {"artworks": []}
  doc = File.open('files/van-gogh-paintings.html') { |f| Nokogiri::HTML(f) }
  carousel = doc.xpath("//g-scrolling-carousel")
  # TODO this navigation is brittle
  elements = carousel.children.first.children.first.children
      
  # TODO replace values w/ parse
   elements.each {|e| finalArray[:artworks].push(Challenge.parse(e))}

  puts JSON.pretty_generate(finalArray)
end
