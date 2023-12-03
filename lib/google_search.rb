require 'nokogiri'
require 'json'

class GoogleSearch

    attr_accessor :url

    def initialize
        @url = 'https://www.google.com'
    end

    def get_artworks(file)
        if File.extname(file) != '.html'
            raise Exception.new('Please provide html file')
        end
        artworks = []

        document = Nokogiri::HTML(file)
      
        hash_id_src = {}
        
        document.inner_html.scan(/_setImagesSrc.+?var s=\'(.*?)\'.*?var ii=\[\'(.*?)\'/) do |src, id|
            hash_id_src[id] = src.gsub('\\', '')
        end

        artwork_cards = document.css('.MiPcId.klitem-tr.mlo-c > a')
        
        artwork_cards.each do |artwork_card|
            artwork = {}
            artwork['name'] = artwork_card.attribute('aria-label').value
            extensions = artwork_card.css('.ellip.klmeta').map do |extension|
                extension.text
            end
            artwork['extensions'] = extensions if extensions.length > 0
            artwork_id = artwork_card.css('img').attribute('id').value
            artwork['link'] = @url + artwork_card.attribute('href').value
            artwork['image'] = hash_id_src[artwork_id]

            artworks.push(artwork)
        end

        artworks
    end
end