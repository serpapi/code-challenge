require 'byebug'
require 'json'

class CarouselItem
    def initialize(item)
        hItem = item.to_h;
        @extensions = [];
        @link = 'https://www.google.com' + hItem['href'];
        if(item.at('img').attributes['src'] != nil)
            @image = item.at('img').attributes['src'];
        else
            @image = nil
        end
        item.element_children[1].children.each do |child|
            if(child.values[0].include?('kltat')) 
                @title = child.text.encode("iso-8859-1").force_encoding("utf-8");
            elsif(child.values[0].include?('klmeta'))
                @extensions.push(child.text);
            end
        end
        if(@extensions.length == 0) 
            @extensions = nil; 
        end
    end

    def to_json
        {
            name: @title,
            extensions: @extensions,
            link: @link,
            image: @image
        }
    end
end