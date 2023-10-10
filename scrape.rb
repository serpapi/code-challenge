require 'nokogiri'

class ArtworkExtractor

  def get_artworks(content)
    doc = Nokogiri::HTML(content)
    artworks = []
    images = image_hash(doc)    

    doc.css('.klitem').each do |link|
      res = {}
      
      res['name'] = link.attribute('aria-label').text
      res['link'] = 'https://www.google.com' + link.attribute('href').text
      extensions = link.css('div.ellip.klmeta').map { |d| d.text}
      res['extensions'] = extensions unless extensions.empty?
      image_id = link.at('img').attribute('id').value
      res['image'] = images[image_id]
      artworks << res
    end

    artworks
  end

  private

  def image_hash(doc)
    hash = {}
    doc.inner_html.scan(/setImagesSrc.+?\'(.*?)\'.*?\'(\w+)/) {|img, id| hash[id] = img.delete('\\')}
    hash
  end
end

content = File.open('./files/van-gogh-paintings.html')
pp ArtworkExtractor.new.get_artworks(content)
