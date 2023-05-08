# frozen_string_literal: true

class CarouselItem
  attr_reader :name, :extensions, :link, :image

  def initialize(name:, extensions:, link:, image:)
    @name = name
    @extensions = extensions
    @link = link
    @image = image
  end

  def to_h
    hash = {
      "name" => @name,
      "link" => @link,
      "image" => @image
    }
    hash["extensions"] = @extensions unless @extensions.empty?
    hash
  end

  def to_json(_arg)
    to_h.to_json
  end
end
