require_relative 'base_gallery'
require_relative 'grid_item'

# gallery type for rhcp-member, van-gogh-paintings-new type galleries
class Grid < BaseGallery
  private

  def parse_item(item)
    GridItem.new(item, image_map).to_h
  end

  def container_selector
    'div[data-attrid^="kc:"]'
  end

  def item_selector
    'a'
  end
end
