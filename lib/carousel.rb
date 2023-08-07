class Carousel
  def initialize(document, config = {})
    @document = document
    @config = config
    @scripts = @document.xpath('//script').to_html
  end

  def data
    carousel = @document.xpath(@config[:carousel_parent_selector])
    {
      paintings: tiles(carousel).map(&:data).compact
    }
  end

  def to_json
    data.to_json
  end

  private

  def tiles(carousel)
    carousel.xpath(@config[:carousel_items_selector]).map do |carousel_tile|
      @config[:carousel_tile_klass].new(carousel_tile, @scripts)
    end
  end
end