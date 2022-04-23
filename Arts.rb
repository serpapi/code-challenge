require 'nokogiri'
require 'open-uri'
require 'json'
require 'Utils'

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

      elements = doc.css('g-scrolling-carousel > div > div > div > a')
      elements.each do |l|

        imgTag= l.css('g-img img').first

        image = imageDictionary[imgTag.attributes["id"].value] if !imgTag.nil?
        name = Utils.get_encoded_value(l.css("div div span").text)
        extension = Utils.get_encoded_value(l.css("div div").text).sub(name,'')

        extensions = if extension.nil? || extension.empty? then [] else [extension] end
        
        href= l.attributes['href'].value
        link = if href.start_with? then href else "https://www.google.com#{href}" end

        artwork = Arts::Artwork.new(name,link,image,extensions)
        artworks.push(artwork)
      end
      return artworks
    end

    def get_image_dictionary(doc)
      images = doc.css("script").select{|x| x.text.include?("data:image/jpeg;base64")}
      imgs= images.map{|x| x.text}.flat_map{|x| x.scan(/\'\S+\'/)}

      imgDict = {}
      t =0
      while (t+1)<imgs.count
        imgDict[imgs[t+1].tr("'","")] = imgs[t].tr("'","").tr("\\","")
        t=t+2
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