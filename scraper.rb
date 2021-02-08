require 'HTTParty'
require 'Nokogiri'
require 'selenium-webdriver'
require 'byebug'
require 'json'

=begin

Shortcuts to attirbutes:

GIT VAN GOGH 

            artworks['name'] = paintings_container.css('div.MiPcId').css('a.klitem')[item]['aria-label']
            artworks['extensions'] = [paintings_container.css('div.MiPcId').css('a.klitem')[item].css('div.ellip.klmeta').children.text]
            artworks['link'] = 'www.google.com' + paintings_container.css('div.MiPcId').css('a.klitem')[item]['href']
            artworks['image'] = paintings_container.css('img')[item].values[2]

HIERONYMUS BOSCH and OTHERS

            artworks['name'] = paintings_container.css('a.MiPcId.mlo-c')[0]['aria-label']
            artworks['extensions'] = paintings_container.css('a.MiPcId.mlo-c')[0].css('div.ellip.klmeta').children.text
            artworks['link'] = paintings_container.css('a.MiPcId.mlo-c')[0]['href']
            artworks['image'] = paintings_container.css('img')[0].values[1]
            container << artworks

=end


def scraper
    driver = Selenium::WebDriver.for :firefox
    url = 'file:///c:/Users/alaett/Desktop/serpapi/files/van-gogh-paintings-updated.html'
    file = driver.get(url)
    doc = Nokogiri::HTML((driver.page_source))
    container = []
    paintings_container = doc.css('div.EDblX.DAVP1')
    max_val = doc.css('div.EDblX.DAVP1').children.count()
    for item in 0..max_val -1 # should be -2 with van-gogh-paintings.html

=begin 
    
I have to -2 from max_val with git van-gogh file.

This code misses one item with newer files. 

Bosch, Dali and updated Gogh all work with max_val -1.

    
=end
        artworks = Hash.new
        begin
            artworks['name'] = paintings_container.css('a.MiPcId.mlo-c')[item]['aria-label']
            artworks['extensions'] = [paintings_container.css('a.MiPcId.mlo-c')[item].css('div.ellip.klmeta').children.text]
            artworks['link'] = 'https://www.google.com' + paintings_container.css('a.MiPcId.mlo-c')[item]['href']
            artworks['image'] = paintings_container.css('img')[item].values[1] 
        rescue
            artworks['name'] = paintings_container.css('div.MiPcId').css('a.klitem')[item]['aria-label']
            artworks['extensions'] = [paintings_container.css('div.MiPcId').css('a.klitem')[item].css('div.ellip.klmeta').children.text]
            artworks['link'] = 'www.google.com' + paintings_container.css('div.MiPcId').css('a.klitem')[item]['href']
            artworks['image'] = paintings_container.css('img')[item].values[2]
        end
        container << artworks
    end
    File.open("files/expected_array.json","w") do |f|
        f.write('"artworks": ')
        f.write(JSON.pretty_generate(container))
    end
    byebug
end

scraper