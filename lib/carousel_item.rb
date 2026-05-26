# Extracts name, extensions, link, and image from a single carousel node.
class CarouselItem
  def initialize(node, images, layout)
    @node   = node
    @images = images
    @layout = layout
  end

  def to_h
    {
      name:,
      link:,
      image:,
      **({ extensions: } unless extensions.empty?)
    }
  end

  private

  def name
    @layout.name(@node)
  end

  def extensions
    ext = @layout.extension(@node)
    ext.to_s.empty? ? [] : [ext]
  end

  def link
    @layout.link(@node)
  end

  def image
    img = @node.css(@layout.image_selector).first
    return unless img

    @images[img.attr("id")] || img.attr("data-src")
  end
end
