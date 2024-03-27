require 'nokogiri'
require 'open-uri'


html_file = './files/van-gogh-paintings.html'


html_content = File.open(html_file)


doc = Nokogiri::HTML(html_content)

title = doc.css('title').text
puts "Title of the page: #{title}"


html_content.close
