require 'nokogiri'
require 'open-uri'
require 'base64'

class SearchParser
  def initialize content
    @page = Nokogiri::HTML(content)
  end

  def parse
    elements = @page.css('g-scrolling-carousel div > div')

    artworks = []

    div_element_length = elements.xpath('./div').length - 1
    
    for i in 0..div_element_length do
      element = elements.xpath('./div')[i]
      parsed  = self.parse_element element

      artworks.push(parsed) if parsed != nil
    end

    result = { 'artworks': artworks }

    return result
  end

  def parse_element element
    return nil unless self.is_valid element
    
    name    = self.get_name element
    extension = self.get_ext element
    link    = self.get_link element
    img     = self.get_img element

    parsed = {
      'name' => name,
      'link' => link,
      'image' => img
    }
    if extension.to_s.length > 0
      parsed['extensions'] = [extension.to_s]
    end
    return parsed
  end


  def is_valid element
    link = element.xpath('./a').attr('href')
    link != nil
  end

  def get_name element
    element.xpath('./a').attr('aria-label').to_str
  end

  def get_ext element
    element.css('.ellip.klmeta').text.to_s
  end

  def get_link element
    link   = element.xpath('./a').attr('href').to_str
    prefix = 'https://www.google.com'
    link   = prefix + link unless link.start_with? prefix
    
    link
  end  

  def get_img element
    img    = element.css('g-img > img')
    result = img.attr('data-key')

    result = img.attr("src") if result == nil
    
    result = result.to_str unless result == nil
    
    get_base_64 result
  end

  def get_base_64(result)
    return result if result.nil?

    image = open(result)
    Base64.encode64(image.read)
  end
end