require 'nokolexbor'

require_relative 'carousel_a'
require_relative 'carousel_b'
require_relative 'grid'

class KnowledgeGraph
  GALLERY_TYPES = [
    CarouselA, # van-gogh-paintings
    CarouselB, # list-of-popes
    Grid # rhcp-members, van-gogh-paintings-new
  ]

  attr_reader :html

  def initialize(html)
    @html = html
  end

  def to_h
    {
      artworks: parse_gallery
    }
  end

  private

  def parse_gallery
    try_gallery_types.find(&:any?) || []
  end

  def try_gallery_types
    GALLERY_TYPES.lazy.map do |gallery_type|
      gallery_type.new(doc).to_a
    rescue ElementNotFoundError
      []
    end
  end

  def doc
    @doc ||= Nokolexbor::HTML(html)
  end
end
