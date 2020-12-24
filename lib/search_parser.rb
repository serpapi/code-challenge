require 'nokogiri'
require 'open-uri'
require 'base64'

class SearchParser
  def initialize content
    @page = Nokogiri::HTML(content)
  end

  def parse
    elements ||= @page.xpath('//*[@class="klitem"]')

    artworks = []
    
    elements.map do |section|
      parsed  = self.parse_element section
      artworks.push(parsed) if parsed != nil
    end

    result = { 'artworks': artworks }

    return result
  end

  def parse_element element
    name      = self.get_name element
    extension = self.get_ext element
    link      = self.get_link element
    img       = self.get_img element

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
    element.at_xpath('div/div[contains(@class, "kltat")]').text
  end

  def get_ext element
    element.at_xpath('div/div[contains(@class, "klmeta")]')&.text
  end

  def get_link element
    link = element.attr(:href) || element.parent.attr(:href)
    prefix = 'https://www.google.com'
    link = prefix + link unless link.start_with? prefix
    link
  end  

  def get_img element
    item = element.at_xpath('div/div/g-img/img/@id').text 
    regex = %r{
      var\ss\=\'
      (((?!var\ss\=)[\s\S])+?)\';
      var\sii\=\[\'#{Regexp.quote(item)}\'\]
    }x

    source ||= get_image_src
    source[regex, 1]
  end

  def get_image_src
    combined_scripts = ''

    @page.xpath(
      '/html/body/div[@id="main"]/div[@id="cnt"]' \
      '/script[starts-with(text(), "function _setImagesSrc")]' \
      ' | ' \
      '//div[@id="search"]/div/div[@id="rso"]' \
      '/script[contains(text(), "setImagesSrc")]'
    ).each do |script|
      combined_scripts << script.text.gsub('\\x3d', '=')
    end

    combined_scripts
  end
end