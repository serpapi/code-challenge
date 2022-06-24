require_relative '../src/CarouselItem.rb'
class Carousel
    def initialize(carousel)
        @carouselItems = carousel.css('div.MiPcId').map do |item|
            CarouselItem.new(item.at('a'));
        end
    end

    def artworks
        @carouselItems.map do |item|
            item.to_json
        end
    end
end