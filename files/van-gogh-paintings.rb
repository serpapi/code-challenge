require 'nokogiri'
require 'json'

# class Artworks
#   attr_reader :name
  
#   def initialize(name)
#     @name = name
#   end  
# end

# print "Hello Ruby"

# file = File.open("test.html")
# file_data = file.read
# file.close

html_data = File.read("van-gogh-paintings.html")
#print file_data

parsed_data = Nokogiri::HTML.parse(html_data)
# print parsed_data.title

# tags = parsed_data.xpath("//a")
# tags.each do |tag|
#   puts "#{tag[:href]}\t#{tag.text}"
# end

# tags = parsed_data.xpath("//img")
# images_urls = tags.map {\t\ t[:src]}

tags = parsed_data.xpath('//g-scrolling-carousel//a[@class="klitem"]')
u = tags.map {|t| {
                name: t.children.xpath('.//div[@class="kltat"]').collect(&:text).first,
                extensions: t.children.xpath('.//div[contains(@class,"klmeta")]').collect(&:text),
                link: t[:href], #[0..100], # do we want to display absolute links? 
                image: t.children.xpath('.//img').map{|i| i[:src]}.first
              }}
# v = u.zip(u)
# x = v.map do |t| {name: t[0], test: t[1]} end 
# print x.to_json
# json1 = JSON.generate(t)
# print json1
#print u.to_json
print JSON.pretty_generate(u)

# art1 = Artworks.new("test")
# print art1.name

# t = tags.map do |a| { name: a[:title] } end
# print t
