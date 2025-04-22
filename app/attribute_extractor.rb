require "nokogiri"

class AttributeExtractor

    def initialize(html_file:)
      @doc = Nokogiri::HTML(html_file)
      # find the g-loading tag, 
      icon_tag = @doc.css('g-loading-icon').first
      # then go up 1 element to the parent div
      container_div = icon_tag.parent
      # Inside that div, an a-href tag. 
      a_tag = container_div.css('a').first
      # Get the parent div's class
      @class_to_search = a_tag.ancestors('div').first['class']  
    end


    def get_artworks_attributes_hash
      @cards = @doc.css(".#{@class_to_search}")
      @json_of_cards = []
      @cards.each do |card|
        link_tag = card.css('a').first
        image_tag = card.css('img').first
        name_tag = link_tag.css('div').first
        extension_tag = name_tag.css('div').count > 1 ? link_tag.css('div') : nil
        
        values = {
          name: "#{name_tag.css('div').first.text.strip.gsub(/\s+/, ' ')}",
          extentions: extension_tag ? ["#{name_tag.css('div').last.text.strip}"] : nil,
          link: "#{link_tag['href']}",
          image: "#{image_tag['src']}",
        }
        @json_of_cards << values
      end
      @json_of_cards
    end
end
