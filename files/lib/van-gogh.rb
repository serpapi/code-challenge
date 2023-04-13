require 'nokogiri'
require 'json'

class Scraper
  def scrape(path)
    file = File.read(path)
    doc = Nokogiri::HTML(file)
    items = doc.css('.klitem')
    array_list = []
    previous_image_id = ''
    image = ''
    images = []
    items.each do |element|
      image_id = element.xpath('.//img[contains(@id, "kximg")]').attr('id').value
      if (image_id.length == 6) and (image_id[-1] == '0')
        image_src = doc.text[%r/\(function\(\){var s='(.*?)';var ii=\['#{image_id}'\];/m, 1]
      else
        image_src = doc.text[%r/#{previous_image_id}'\];_setImagesSrc\(ii,s\);}\)\(\);\(function\(\){var s='(.*?)';var ii=\['#{image_id}/m, 1]
      end
      previous_image_id = image_id
      image = nil
      if image_src != nil then image = image_src.gsub("\\x", "x") end
      extension = element.search('wbr').xpath('../../div[@class and text()]/text()')
      if extension.length != 0
        array = {
          "name": element.attr('aria-label'),
          "extensions": [extension],
          "link": 'https://www.google.com' + element.attr('href'),
          "image": image
        }
      else
        array = {
          "name": element.attr('aria-label'),
          "link": 'https://www.google.com' + element.attr('href'),
          "image": image
        }
      end
      array_list.append(array)
      images.append(image)
    end
    File.open("fetched-array.json", "w") do |f|
      f.write(JSON.pretty_generate(array_list))
    end
    return [items, array_list, images] # This return will be used on testing.
  end
end

Scraper.new.scrape('van-gogh-paintings.html')
