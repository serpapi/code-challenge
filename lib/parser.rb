require 'nokogiri'

class Parser
  def initialize content
    @doc = Nokogiri::HTML(content)
  end

  def parse
    elements = @doc.css('g-scrolling-carousel div > div')

    artworks = []
    for i in 0..elements.xpath('./div').length - 1 do
      element = elements.xpath('./div')[i]
      parsed = self.parse_element element
      artworks.push(parsed) unless parsed == nil
    end

    result = {
      "artworks"=> artworks
    }
    return result
  end

  def parse_element element
    if !self.is_valid element then
      return nil
    end
    link = self.get_link element
    name = self.get_name element
    extension = self.get_ext element
    img = self.get_img element
    parsed = {
      "name" => name,
      "link" => link,
      "image" => img
    }
    if extension.to_s.length > 0 then
      parsed["extensions"] = [extension.to_s]
    end
    return parsed
  end
  

  def is_valid element
    link = element.xpath('./a').attr('href')
    return link != nil
  end

  def get_link element
    link = element.xpath('./a').attr('href').to_str
    prefix = 'https://www.google.com'
    link = prefix + link unless link.start_with? prefix
    return link
  end    

  def get_name element
    return element.xpath('./a').attr('aria-label').to_str
  end 

  def get_ext element
    return element.css('.ellip.klmeta').text.to_s
  end

  def get_img element
    img = element.css('g-img > img')
    result = img.attr("data-key")
    if result == nil then
      result = img.attr("src")
    end
    result = result.to_str unless result == nil
    return result
  end

end
