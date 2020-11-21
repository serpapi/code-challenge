require 'json'
require 'nokogiri'

HOSTNAME = 'https://www.google.com'

def parse_carousel(filename)
  doc = Nokogiri::HTML(File.read(filename))

  carousel = doc.at_xpath('//g-scrolling-carousel')
  output = carousel.xpath('//div[contains(@class, "klitem-tr")]/a[contains(@class, "klitem")]').map do |item|
    name = item.at_xpath('div/div[contains(@class, "kltat")]').text
    extension = item.at_xpath('div/div[contains(@class, "klmeta")]')&.text

    link = HOSTNAME + item.xpath('@href').text
    image_id = item.at_xpath('//g-img/img/@id').text

    base64 = get_full_base64(doc, image_id)

    {
      name: name,
      extension: [extension],
      link: link,
      image: base64
    }
  end

  File.write('output.json', JSON.pretty_generate({ artworks: output }))
end

def get_full_base64(doc, selector)
  regex = /var s\=\'([\s\S]*)\';var ii\=\[\'#{Regexp.quote(selector)}\'\]/

  @script ||= doc.at_xpath(
    '/html/body/div[@id="main"]/div[@id="cnt"]'\
    '/script[starts-with(text(), "function _setImagesSrc")]'
  ).text

  @script[regex, 1]
end

parse_carousel('van-gogh-paintings.html')
