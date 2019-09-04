require 'bundler/setup'

require 'open-uri'
require 'nokogiri'

url = './files/van-gogh-paintings.html'

html = open(url)

doc = Nokogiri::HTML(html)

# Array.from(document.querySelectorAll('.klitem')).map(el => ({ name: el.querySelector('.kltat').textContent, image: el.querySelector('g-img img').src, extensions: [ el.querySelector('.klmeta') && parseInt(el.querySelector('.klmeta').textContent) ], link: el.href }))

paintings = doc.css('.klitem').map do |painting|
  parsed_painting = {
    name: painting.at_css('.kltat').content,
    image: painting.at_css('img') ? painting.at_css('img').attr('src') : nil,
    link: painting.attr('href'),
  }

  parsed_painting[:extensions] = [ painting.at_css('.klmeta').text ] if painting.at_css('.klmeta')

  parsed_painting
end

puts paintings