require 'json'

class Artwork
  attr_reader :name, :extensions, :link, :image

  def initialize(name:, extensions:, link:, image:)
    @name = name
    @extensions = extensions.delete_if(&:empty?)
    @link = link
    @image = image
  end

  def to_h
    data = { name: name, link: link, image: image }
    data[:extensions] = extensions unless extensions.empty?
    data
  end

  def to_json
    to_h.to_json
  end
end
