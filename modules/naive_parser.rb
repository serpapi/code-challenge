# frozen_string_literal: true

require 'nokogiri'
require 'json'

# this works on the original van-gogh-paintings.html file only - it is a naive implemention that is using class names.
# this was to get my bearings, but leaving for posterity
class NaiveParser
  def parse(html)
    doc = Nokogiri::HTML(html)

    encoded_images = {}
    doc.css('script').each do |script|
      text = script.text
      var_ii = text.match(/var ii=\['[a-zA-Z0-9_](.+?)'\]/)
      ii = var_ii.to_s.split("'")[1]
      var_s = text.match(%r{var s='data:image/jpeg;base64,/[0-9a-zA-Z](.+?)';})

      next unless var_s

      s = var_s.to_s.split("'")[1]
      s = s.gsub(/\\x([0-9a-fA-F]{2})/) { [Regexp.last_match(1)].pack('H*') }

      encoded_images[ii] = s
    end

    paintings = []
    doc.css('.iELo6').each do |item|
      img = item.at_css('img')
      image = img['data-src']
      unless image
        img_id = img['id']
        image = encoded_images[img_id]
      end

      painting = {
        name: item.css('.pgNMRc').text,
        link: "https://www.google.com#{item.at_css('a')['href']}",
        image: image
      }

      year = item.css('.cxzHyb').text
      painting[:extensions] = [year] unless year.empty?

      paintings << painting
    end

    { artworks: paintings }.to_json
  end
end
