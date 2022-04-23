require 'nokogiri'
require 'open-uri'
require 'json'
require 'Utils'
require 'Constants'

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

      elements = doc.css(Constants::Selectors::CAROUSEL_LINKS)
      elements.each do |element|

        name = get_name(element)
        link= get_link(element)
        image = get_image(element, imageDictionary)
        extensions = get_extensions(element)

        artwork = Arts::Artwork.new(name,link,image,extensions)
        artworks.push(artwork)
      end
      return artworks
    end

    def get_image_dictionary(doc)
      images = doc.css("script").select{|x| x.text.include?("data:image/jpeg;base64")}
      imgs= images.map{|x| x.text}.flat_map{|x| x.scan(/\'\S+\'/)}

      imgDict = {}
      index =0
      while (index+1)<imgs.count
        imgDict[imgs[index+1].tr("'","")] = imgs[index].tr("'","").tr("\\","")
        index=index+2
      end
      return imgDict
    end

    def get_link(element)
      href = element.attributes['href'].value
      return "https://www.google.com#{href}"
    end

    def get_image(element, imageDictionary)
        imgTag= element.css(Constants::Selectors::IMAGE).first
        return imageDictionary[imgTag.attributes["id"].value] if !imgTag.nil?
    end

    def get_name(element)
      return Utils.get_encoded_value(element.attributes["aria-label"].text)
    end

    def get_extensions(element)
      extension = Utils.get_encoded_value(element.css(Constants::Selectors::EXTENSION).text)
      extensions = if extension.nil? || extension.empty? then [] else [extension] end
      return extensions
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