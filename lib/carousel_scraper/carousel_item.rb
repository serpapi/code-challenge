module CarouselScraper
  class CarouselItem
    def initialize(params = {})
      @name = params[:name]
      @extensions = params[:extensions] || []
      @link = params[:link]
      @image = params[:image]
    end

    def as_json
      {
        name: @name,
        extensions: @extensions,
        link: @link,
        image: @image
      }
    end
  end
end
