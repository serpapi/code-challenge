require 'nokogiri'
require 'ferrum'
gem 'awesome_print'

class SearchParser
  def initialize path
    @path = path
  end

  def parse
    browser = Ferrum::Browser.new
    browser.go_to("file://#{Dir.pwd}/#{@path}")

    parsed = Nokogiri::HTML.parse(browser.body)
    caroussel = parsed.xpath("//g-scrolling-carousel")
    items = caroussel.css(".klitem")

    @output = {"artworks" => []}
    items_output = @output["artworks"]

    items.each_with_index do |item, i|
      name = item.css('.kltat').text
      extensions = item.css('.klmeta').to_a.map{|e| e.text}
      link = item['href']
      link = "https://www.google.com#{link}" if link.start_with?('/')
      image = item.xpath('.//g-img/img')[0].attr('src')

      items_output << {
        "name" => name,
        "extensions" => extensions,
        "link" => link,
        "image" => image
      }
    end

    @output
  end

  def to_s
    JSON.pretty_generate(@output)
  end
end
