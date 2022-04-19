
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
  attr_accessor :name, :extensions, :link

  def initialize(name,link, extensions) 
    @name = name
    @link = link
    @extensions = extensions
  end

  def to_json()
    if !@extensions.empty?
      """{
        \"name\": \"#{@name}\",
        \"extensions\": #{@extensions},
        \"link\": \"#{@link}\",
      }"""
    else
      """{
        \"name\": \"#{@name}\",
        \"link\": \"#{@link}\",
      }"""
    end
  end

  
end

# Fetch and parse HTML document
doc = Nokogiri::HTML(URI.open('./files/van-gogh-paintings.html'))

elements = doc.xpath('/html/body/div[6]/div[3]/div[7]/div[1]/div/div/div[2]/div[2]/div/div/g-scrolling-carousel/div/div/div')

artworks = Artworks.new
elements.each do |l|
  title= l.children[1].children[2].children[1].text.strip
  # extensions = link.children[1].children[2].children[3].text
  extensions = []
  l.children[1].children[2].children.each do |child|
    txt = child.text.strip
    if(!txt.empty? && txt != title)
      extensions.push(child.text.strip)
    end
  end
  image = nil
  link = "https://www.google.com#{l.children[1].attributes["href"].value}"

  artwork = Artwork.new(title,link,extensions)
  artworks.add(artwork)
end

path = './files/actual.json'
File.write(path,artworks.to_json)
