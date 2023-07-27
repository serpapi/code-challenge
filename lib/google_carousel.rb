class GoogleCarousel

  attr_reader :raw_html, :doc

  def initialize(raw_html)
    @raw_html = raw_html
  end

  def parse
    @doc = Parsers::Docuemnt.new(raw_html).parse

    carousel_items = []
    doc.at_css('g-scrolling-carousel').traverse do |x|
      if (x.name == 'a')
        carousel_items << GoogleCarousel::Parsers::CarouselItem.new(x)
      end
    end

    result = { artworks: [] }
    carousel_items.each do |item|
      result[:artworks] << {
        name: item.name,
        link: item.link
      }
    end
  end

  private

  def carousel_images
    @carousel_images ||= GoogleCarousel::Extract::CarouselImage.new(doc).fetch_images
  end
end
