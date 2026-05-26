require "nokolexbor"

# Extracts name, extensions, link, and image from a single carousel node.
class CarouselItem
  def initialize(node, images)
    @node = node
    @images = images
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
    @node.css(".pgNMRc").first&.text
  end

  def extensions
    ext = @node.css(".cxzHyb").first&.text
    ext.to_s.empty? ? [] : [ext]
  end

  def link
    href = @node.css("a").first&.attr("href")
    href&.start_with?("/") ? "https://www.google.com#{href}" : href
  end

  def image
    img = @node.css("img.taFZJe").first
    return unless img

    @images[img.attr("id")] || img.attr("data-src")
  end
end
