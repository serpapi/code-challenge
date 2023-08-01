class Image
  attr_accessor :extensions, :image, :link, :name

  ATTRIBUTES = %w[extensions image link name]

  def to_h
    { extensions:, image:, link:, name: }
  end
end