require 'nokogiri'
require 'byebug'

# encoding: UTF-8

class GoogleImageSearch
  class << self
    def search(q: 'Van Gogh paintings')
      result = {}

      filename = q.split(' ').map(&:downcase).join('-')

      doc = File.open(File.join(__dir__, "../files/#{filename}.html")) do |f| 
        Nokogiri::HTML(f, nil, Encoding::UTF_8.to_s)
      end

      # Here's the trick: we ain't need selenium or any other headless web driver to execute the JS that fills the thumbails
      # These data can be extracted by regex in the JS code - Thank you @google for keeping the order coherent
      raw_html_text = File.open(File.join(__dir__, '../files/van-gogh-paintings.html'), "r:UTF-8", &:read)
      thumbnail_srcs = raw_html_text.scan /var\s+s\='([^']+)';/

      # Google changed the page structure now in 2020
      # I have to adapt the extraction for the provided van Gogh file and Picasso|Monet that I add today at 2020-07-15
      artwork_link_elements = if doc.xpath('//g-scrolling-carousel//a[@class="MiPcId klitem-tr mlo-c"]').length > 0
        doc.xpath('//g-scrolling-carousel//a[@class="MiPcId klitem-tr mlo-c"]')
      else
        doc.xpath('//g-scrolling-carousel//a[@class="klitem"]')
      end
      
      index = 0

      result[:artworks] = artwork_link_elements.map do |artwork_link|
        name_elements = artwork_link.children.xpath('./div[@class="kltat"]//span')
        name_elements = artwork_link.children.xpath('.//div[@class="kltat"]//span') if name_elements.empty? # Google changed the page structure now in 2020 so we need to support old and actual page structures

        item = {
          name: name_elements.map(&:content).map(&:strip).join(" "),
          link: ('https://www.google.com' + artwork_link.xpath('@href').first&.value),
          image: thumbnail_srcs[index]&.first&.gsub(/\\/, '') # JS code escaping formatting
        }

        ext = artwork_link.children.xpath('./div[@class="ellip klmeta"]').map(&:content)
        item[:extensions] = ext if ext.any?

        index += 1

        item
      end

      result
    end
  end
end