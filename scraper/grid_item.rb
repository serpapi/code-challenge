require_relative 'carousel_item_a'

class GridItem < CarouselItemA
  private

  def name
    node.css('div:nth-child(2) > div:first-child').text
  end
end
