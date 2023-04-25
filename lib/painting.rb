class Painting
  def initialize(name:, link:, image:, extensions: [])
    @name = name
    @link = link
    @image = image
    @extensions = extensions
  end

  def to_json
    {
      name: @name,
      link: @link,
      image: @image,
      extensions: @extensions
    }
  end
end