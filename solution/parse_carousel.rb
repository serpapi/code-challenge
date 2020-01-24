class ParseCarousel
  CAROSEL_ITEMS_CSS = '.MiPcId.klitem-tr.mlo-c'.freeze

  attr_reader :extracted_carosel_items

  def initialize
    @extracted_carosel_items = []
  end

  def extract_carosel_items!(html_str)
    html = Nokogiri::HTML(html_str)
    @extracted_carosel_items = html.css(CAROSEL_ITEMS_CSS).map { |cih| CarouselItem.new(cih) }
  end

  def to_json
    JSON.pretty_generate(@extracted_carosel_items.map(&:to_h))
  end
end
