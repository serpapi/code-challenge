
require 'nokogiri'
require 'open-uri'
require 'json'

class Artworks
  attr_accessor :artworks

  def initialize
    @artworks = []
  end
  def add(artwork)
    @artworks.push(artwork)
  end

  def to_json()
    """ \"artworks\": [
      #{@artworks.map{|x| x.to_json}.join(",")}
    ]"""
  end

  
end

class Artwork
  attr_accessor :name, :extensions, :link, :image

  def initialize(name,link,image, extensions) 
    @name = name.split(' ').join(' ')
    @link = link
    @extensions = extensions
    @image = if !image.nil? then "\"#{image}\"" else "null" end
  end

  def to_json()
    if !@extensions.empty?
      """{
        \"name\": \"#{@name}\",
        \"extensions\": #{@extensions},
        \"link\": \"#{@link}\",
        \"image\": #{@image}
      }"""
    else
      """{
        \"name\": \"#{@name}\",
        \"link\": \"#{@link}\", 
        \"image\": #{@image}
      }"""
    end
  end

  
end

# Fetch and parse HTML document
doc = Nokogiri::HTML(URI.open('./files/van-gogh-paintings.html'))

elements = doc.xpath('/html/body/div[6]/div[3]/div[7]/div[1]/div/div/div[2]/div[2]/div/div/g-scrolling-carousel/div/div/div')

images = doc.xpath("/html/body/div[6]/div[3]/script[4]").text.split("function()")

imgDict = {}
images.each do |i|
  vals = i.split("\'")
  if(!vals[1].nil?)
    imgDict[vals[3]] = vals[1].gsub "\\", ""
  end
end


artworks = Artworks.new
elements.each do |l|
  title= l.children[0].attributes['aria-label'].value
  imgTag= l.children.children.children.children.children[0].attributes["id"]
  image = nil
  image = imgDict[imgTag.value] if !imgTag.nil?

  extensions = []
  ext =l.children.children.children.children.last.text
  if(!ext.empty?)
    extensions.push(ext)
  end
  href= l.children[0].attributes['href'].value
  link = "https://www.google.com#{href}"

  artwork = Artwork.new(title,link,image,extensions)
  artworks.add(artwork)
end

path = './files/actual.json'
File.write(path,artworks.to_json)
