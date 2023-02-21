class Artwork
  attr_reader :name, :extensions, :link, :image

  def initialize(name:, extensions:, link:, image:)
    @name = name
    @extensions = extensions
    @link = link
    @image = image
  end

  def to_h
    extensions.empty? ? { name:, link:, image: } : { name:, extensions:, link:, image: }
  end
end
