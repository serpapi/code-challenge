require 'nokogiri'
require 'json'

html_data = File.read("van-gogh-paintings-20210831.html")
# html_data = File.read("bukowski-books.html")

parsed_data = Nokogiri::HTML.parse(html_data)

tags = parsed_data.xpath('//g-scrolling-carousel//a[contains(@class, "klitem") and *]')
artworks = tags.map {|t| {
                name: t.children.xpath('.//div[@class="FozYP" and @jsname]').collect(&:text).join(),
                extensions: t.children.xpath('.//div[@class="FozYP" and not(@jsname)]').collect(&:text),
                link: t[:href], # do we want to display absolute links? 
                image: t.children.xpath('.//img').map{|i| i[:src]}.first
              }}

print JSON.pretty_generate(artworks)

puts "Confirm all values are present: "
puts artworks.all? {|a| a.values_at(:name, :extensions, :link, :image).all?}
# artworks.each {|a| puts a.values_at(:name, :extensions, :link, :image).all? }
