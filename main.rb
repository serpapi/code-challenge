require 'nokogiri'
require 'open-uri'


html_file = './files/van-gogh-paintings.html'


html_content = File.open(html_file)


doc = Nokogiri::HTML(html_content)

images_data = []
parent = doc.css('#_c2yRXMvVOs3N-QazgILgAg93')

parent.css('a').each do |link|
  title = link['title']
  href = link['href']

  image_src = link.css('img').first['src'] unless link.css('img').empty?
  puts link.css('img')
  extensions = title.scan(/\((.*?)\)/).flatten

  name = title.gsub(/\s*\([^)]+\)/, '')
  images_data << {
    name: name,
    extensions: extensions,
    link: href,
 
  }
end

# puts images_data.inspect

html_content.close
