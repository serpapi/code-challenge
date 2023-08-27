# frozen_string_literal: true

require 'nokogiri'
require 'json'

module Challenge  

  #TODO implement a proper class for describing these items
  #break a carousel item up into core components
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
    imageValue = imageMap[imageKey.value]
    if imageValue.to_s.empty?
      result[:image] = nil
    else
      result[:image] = imageValue.to_s.tr('\\','')   
    end
    
    result
  end

  # parses the image replacement script function, then slices it up into a map
  def self.build_image_map(doc)    
    scripts = doc.css("script");    
    scripts.each do |script|      
      next unless script.inner_html.include?("_setImagesSrc")      
      imageMap = {}
      doc.inner_html.scan(/setImagesSrc.+?\'(.*?)\'.*?\'(\w+)/) {|data,id| imageMap[id] = data}     
      return imageMap 
    end
  end

  def self.process_page()
    finalArray = {"artworks": []}
    # TODO add input mechanism for changing input file
    # TODO add switch for specifying live page queries
    doc = File.open('files/van-gogh-paintings.html') { |f| Nokogiri::HTML(f) }
    imageMap = build_image_map(doc)
    carousel = doc.xpath("//g-scrolling-carousel")
    # TODO this navigation is brittle, maybe replace with finding by klitem?
    elements = carousel.children.first.children.first.children
        
    elements.each {|e| finalArray[:artworks].push(parse(e, imageMap))}

    JSON.pretty_generate(finalArray)
  end
  class Error < StandardError; end  
end
