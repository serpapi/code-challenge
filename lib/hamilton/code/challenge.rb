# frozen_string_literal: true

require 'nokogiri'
require 'json'

module Challenge  
  def self.parse(e, imageMap)
    result = {}    
    result[:name] = e.child.attribute_nodes.select {|a| a.name == "aria-label"}[0].value
    
    
    extensions = []
    meta = e.css(".klmeta").first
    if (meta)
      meta.children.each {|c| extensions.push(c.to_s)}
      result[:extensions] = extensions
    end    
    
    result[:link] = "https://google.com" + e.child.attribute_nodes.select {|a| a.name == "href"}[0].value
    
    imageKey = nil
    imageKey = e.css("g-img").first.children.first.attribute_nodes.select {|a| a.name == "id"}[0]        
    if imageMap[imageKey.value].to_s.empty?
      result[:image] = nil
    else
      result[:image] = imageMap[imageKey.value].to_s.tr('\\','')   
    end
    
    return result
  end

  def self.build_image_map(doc)    
    scripts = doc.css("script");    
    scripts.each do |script|      
      next unless script.inner_html.include?("_setImagesSrc")      
      imageMap = {}
      doc.inner_html.scan(/setImagesSrc.+?\'(.*?)\'.*?\'(\w+)/) {|data,id| imageMap[id] = data}     
      return imageMap 
    end
  end

  class Error < StandardError; end
  finalArray = {"artworks": []}
  doc = File.open('files/van-gogh-paintings.html') { |f| Nokogiri::HTML(f) }
  imageMap = build_image_map(doc)
  carousel = doc.xpath("//g-scrolling-carousel")
  # TODO this navigation is brittle
  elements = carousel.children.first.children.first.children
      
  # TODO replace values w/ parse
   elements.each {|e| finalArray[:artworks].push(parse(e, imageMap))}

  puts JSON.pretty_generate(finalArray)
end
