require 'uri'
require 'json'

class ArtworkExtractor
    def initialize(painting_element)
        @painting_element = painting_element
        @title = @painting_element&.attr('title')
    end
  
    def check_artwork
        !name.nil? && !name.empty? &&
        !image.nil? && !image.empty? &&
        !link.nil? && !link.empty? &&
        !extensions.nil? && !extensions.empty?
    end
      
  
    def name
        @painting_element&.attr('aria-label') || @title
        full_name = @painting_element&.attr('aria-label') || @title
        title_only = full_name&.split('.')&.first&.strip
        title_only
          
    end

    def extensions
        if year
            [year]
        else
            []
        end
    end

    def year
        year = @title[/\d{4}/] if @title
        if year.nil? && @painting_element && @painting_element.children && @painting_element.children[1]
          year = @painting_element.children[1].text[/\d{4}/]
        end
        year
    end

    def link
        url = @painting_element&.attr('href')
        url = url.gsub(/^https?:\/\/google\.com/, '') if url
        "https://google.com#{url}" if url
    end
  
    def image
        @painting_element&.css('img')&.first&.[]('src')
    end
  end


class Artwork
    def initialize(name:, link:, image:, extensions: nil)
        @name = name
        @extensions = Array(extensions)
        @link = link
        @image = image
    end

    def to_hash
        {
        name: @name,
        extensions: @extensions,
        link: @link,
        image: @image
        }
    end
end