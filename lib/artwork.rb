class Artwork
  attr_reader :name, :link, :image, :extensions

  def initialize(name:, link:, image:, extensions: [])
    @name = name
    @link = link
    @image = image
    @extensions = extensions
  end
end