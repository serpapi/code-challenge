require 'nokogiri'
require 'json'

module Paintings
  
  
  
  def self.image(doc, image_id)
    doc.css('script').each do |s|
      
      image_regex = /\'(?<src>[^']*)\';var ii=\[\'#{image_id}\'/
      match = image_regex.match(s)
      if match
        return match[:src]
      end
    end
    return nil
  end
  
  def self.paintings(html_file)
    open(html_file, 'rb') do
      |f|
      buf = f.read
       
      doc = Nokogiri::HTML( buf)
      artworks = doc.css('a.klitem').map do 
        |e|
        desc = {
          :name => e.css('div.kltat')[0].content,
          :link => e['href'],
        } 
        
        extensions = e.css('div.ellip').map do
          |e2| e2.content
        end
        
        unless extensions.empty?
          desc[:extensions] = extensions
        end
        
        image_id = (e.css('img').map do
          |e2| e2['id']
        end)[0]
        
        image_ = image(doc, image_id)
        if image_
          desc[:image] = image_
        end 
        desc
      end
      
      return {:artworks => artworks} 
      
    end
  end

end