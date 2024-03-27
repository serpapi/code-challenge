require 'nokogiri'
require 'cgi'
require 'json'
require 'uri'

def decode_html_entities(string)
  CGI.unescapeHTML(string)
end

def find_image_script(source, img_id)
  pattern = /\(function\(\)\{var s='([^']+)';var ii=\['#{img_id}'\];_setImagesSrc\(ii,s\);\}\)\(\);/
  source.css('script').find { |script| script.content.match(pattern) }
end

# Accessing the image source in the main script does not return the expected value.
# This is because the html file is static and the javascript is not executed. The work around
# is to parse through the javascript to get the expected src.
def extract_image_source(script, img_id)
  match = script.content.match(/\(function\(\)\{var s='([^']+)';var ii=\['#{img_id}'\];_setImagesSrc\(ii,s\);\}\)\(\);/)
  match[1].gsub('\\x3d', 'x3d').gsub('\\x', 'x')
end

def process_link(link, base_url, doc)
  title = decode_html_entities(link['title'])
  href = base_url + link['href']
  img_id = link.at_css('img')['id']
  script = find_image_script(doc, img_id)
  img_src = extract_image_source(script, img_id) if script
  extensions = title.scan(/\((\d+)\)/).flatten
  item = { name: title.gsub(/ \((\d+)\)/, '') }
  item[:extensions] = extensions unless extensions.empty?
  item.merge!({ link: href, image: (img_src&.empty? ? nil : img_src) })

  item
end

def scrape_images_from_html(html_file)
  doc = Nokogiri::HTML(File.open(html_file))
  base_url = doc.at_css('base')&.attribute('href')&.value || "https://www.google.com"
  parent = doc.at_css('#_c2yRXMvVOs3N-QazgILgAg93')

  parent.css('a').map { |link| process_link(link, base_url, doc) }
end

html_file = './files/van-gogh-paintings.html'
images_data = scrape_images_from_html(html_file)

File.open("out-array.json", "w") do |f|
  f.write(JSON.pretty_generate(images_data))
end
