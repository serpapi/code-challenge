module CarouselScraper
  class CarouselItemParser
    attr_reader :node

    BASE_GOOGLE_URL = 'https://www.google.com'

    def initialize(node, encoded_images)
      @node = node
      @encoded_images = encoded_images
    end

    def title
      @node.attr('aria-label') || @node.attr('title')
    end

    def image
      data_id = @node.css('img').attr('id')&.value
      @encoded_images[data_id] || @node.css('img').attr('src')
    end

    def url
      href = @node.attr('href')
      "#{BASE_GOOGLE_URL}#{href}" if href
    end

    def year
      year = @node.attr('title')[/\d{4}/]
      year ? [year] : []
    end

    def valid_carousel_item?
      !title.nil? && !title.empty? && !url.nil? && !url.empty?
    end

    def transform
      return nil unless valid_carousel_item?

      CarouselItem.new(
        name: title,
        extensions: year,
        link: url,
        image: image
      )
    end
  end
end
