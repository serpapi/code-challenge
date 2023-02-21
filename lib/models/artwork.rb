class Artwork
  attr_reader :name, :extensions, :link, :image, :thumbnail

  def initialize(name:, extensions:, link:, image:, thumbnail:)
    @name = name
    @extensions = extensions
    @link = link
    @image = image
    @thumbnail = thumbnail
  end

  def to_h
    extensions.empty? ? { name:, link:, image:, thumbnail: } : { name:, extensions:, link:, image:, thumbnail: }
  end
end
