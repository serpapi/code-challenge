require 'nokogiri'
require 'json'

class Carousel
    def initialize(html, element)
        @artworks = []
        
        last_id_name = nil
        for child in element.children
            item = Item.new(html, child, last_id_name)
            @artworks.push(item)

            last_id_name = item.id_name
        end
    end

    def to_h
        {
            :artworks => @artworks
        }
    end

    public
    def to_json(*a)
        to_h.to_json(*a)
    end
end

class Item
    attr_accessor :id_name

    def initialize(html, element, last_id_name)
        @html = html
        @element = element
        @image = get_image(last_id_name)
        @link = get_link()
        @name = get_name()
        @extensions = get_extensions()
    end

    private
    def get_image(last_id_name)
        img_elem = @element.at_css("g-img > img")
        if img_elem.nil? then return nil end
        
        @id_name = @element.at_css("g-img > img").attribute("id").text

        # Google first defines the data, then defines the key
        search_string = "{var s='(data:image\/jpeg;base64,.+?)';.+?\\['#{@id_name}'\\]";

        # Find the previous declaration if it exists, to not always find the data for id_number=0
        unless last_id_name.nil?
            search_string = "\\['#{last_id_name}'\\];.+?" + search_string
        end

        regex = Regexp.new(search_string)
        match = regex.match(@html)

        unless match.nil?
            # Remove escaped backslashes
            return match.captures[0].gsub("\\", "")
        end

        return nil
    end

    private
    def get_link()
        linkElement = @element.at_css("a")

        unless linkElement.nil?
            return "https://www.google.com" + linkElement.attribute("href")
        end
        
        return "https://www.google.com" + @element.attribute("href")
    end

    private
    def get_name()
        elem = @element.css(".kltat")
        unless elem.nil?
            return elem.text
        end
        
        return ""
    end

    private
    def get_extensions()
        extensions = []

        for item in @element.css("div:not(.kltat) > div:not(.kltat)")
            extensions.push(item.text) unless item.text.length == 0
        end

        return extensions
    end

    def to_h
        {
            :name => @name,
            :extensions => @extensions,
            :link => @link,
            :image => @image
        }
    end

    public
    def to_json(*a)
        to_h.to_json(*a)
    end
end

file_name = "files/van-gogh-paintings.html"
html = File.read(file_name)
document = Nokogiri::HTML(html)

carousel = Carousel.new(document, document.at_css("[jsname=s2gQvd]"))

file = File.open("result.json", 'w')
file.write JSON.pretty_generate(carousel)