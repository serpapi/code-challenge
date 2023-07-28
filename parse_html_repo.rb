require 'nokogiri'
require 'httparty'

def scraper()
  url = "https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html"
  response = HTTParty.get(url)

  doc = Nokogiri::HTML(response.body)
  artworks = []

  doc.css('a.klitem').each do |result|
    extensions = []

    title_div = result.css('div.kltat')

    title_text = ""

    title_div.each do |item|
      item.css('span').each do |text|
        title_text << text
      end
    end

    if !result.css('div.ellip').empty?
      extensions << result.css('div.ellip').text
    end

    link = "https://www.google.com" << result['href']

    src = result.css('img')[0]['src']

    artworks << { "name": title_text, "extensions": extensions, "link": link, "image": src }

  end

  artworks

end

puts scraper