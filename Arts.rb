require 'nokogiri'
require 'open-uri'
require 'json'

module Arts
  class Artworks
    attr_accessor :artworks

    def initialize(html_path)
      doc = Nokogiri::HTML(URI.open(html_path))
      @artworks = get_artworks(doc)
    end

    def to_s(options={})
      """\"artworks\": [
          #{@artworks.map{|x| JSON.pretty_generate(x)}.join(",\n")}
        ]"""
    end

private
    def get_artworks(doc)
      artworks=[]
      imageDictionary = get_image_dictionary(doc)
      
      elements = doc.xpath('/html/body/div[6]/div[3]/div[7]/div[1]/div/div/div[2]/div[2]/div/div/g-scrolling-carousel/div/div/div')
      elements.each do |l|
        nameFromHtml = l.children[0].attributes['aria-label'].value
        name= Utils.get_encoded_value(nameFromHtml)
        imgTag= l.children.children.children.children.children[0].attributes["id"]

        image = imageDictionary[imgTag.value] if !imgTag.nil?

        extensions = l.children.children.children.children
          .select{|x| !x.text.empty?}
          .select{|x| !name.include?(Utils.get_encoded_value(x.text))}
          .map{|x| x.text}
        
        href= l.children[0].attributes['href'].value
        link = "https://www.google.com#{href}"

        artwork = Arts::Artwork.new(name,link,image,extensions)
        artworks.push(artwork)
      end
      return artworks
    end

    def get_image_dictionary(doc)
      images = doc.xpath("/html/body/div[6]/div[3]/script[4]").text.split("function()")

      imgDict = {}
      images.each do |i|
        vals = i.split("\'")
        if(!vals[1].nil?)
          imgDict[vals[3]] = vals[1].gsub "\\", ""
        end
      end
      return imgDict
    end
  end

  class Artwork
        attr_accessor :name, :extensions, :link, :image

        def initialize(name,link,image, extensions) 
            @name = name.split(' ').join(' ')
            @link = link
            @extensions = extensions
            @image = image
        end

        def as_json(options={})
            if !@extensions.empty?
            {
                :name=> @name,
                :extensions => @extensions,
                :link => @link,
                :image => @image
            }
            else
            {
                :name => @name,
                :link => @link,
                :image => @image
            }
            end
        end

        def to_json(*options)
            as_json(*options).to_json(*options)
        end
    end
end