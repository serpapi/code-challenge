require 'nokogiri'
require_relative "./carousel_item"
require "json"
class GoogleCarousel
  def self.get_carousel
    result = []
    File.open("files/van-gogh-paintings.html", "r") do |f|
      doc = Nokogiri::HTML(f, nil, "UTF-8")
      first_carousel = doc.css("g-scrolling-carousel")[0]
      first_carousel.css(".klitem").each do |match|
        c= CarouselItem.new(match)
        result.push(c.to_json)
      end
    end
    return result
  end
end