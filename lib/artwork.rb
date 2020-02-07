# frozen_string_literal: true

class Artwork
  attr_accessor :name, :extensions, :link, :image

  def extensions
    @extensions ||= []
  end

  #  {
  #     "name": "...",
  #     "extensions": [
  #       "..."
  #     ],
  #     "link": "...",
  #     "image": "..." or null
  #  }
  def as_json
    {
      name: name,
      extensions: extensions,
      link: link,
      image: image
    }
  end
end
