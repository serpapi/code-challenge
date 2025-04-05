# frozen_string_literal: true

require 'nokolexbor'
require 'open-uri'

module GoogleArtworksParser
  def self.parse(uri)
    { 'artworks' => Parser.collect_from(uri) }
  end

  class Parser
    attr_accessor :artworks

    def self.collect_from(uri)
      parser = Parser.new(uri)
      parser.artworks
    end

    private

    def initialize(uri)
      @doc = Nokolexbor::HTML(URI.open(uri)) # rubocop:disable Security/Open
      @lazy_images = collect_lazy_images
      @artworks = collect_artworks
    end

    attr_accessor :doc, :lazy_images

    ARTWORK_CSS_CLASS = '.iELo6'
    EXTENSION_CSS_CLASS = '.cxzHyb'
    NAME_CSS_CLASS = '.pgNMRc'
    IMG_CSS_CLASS = '.taFZJe'

    def collect_lazy_images
      img_with_id_regex = %r{var s='(data:image/jpeg;base64,.*?)';var ii=\['(.*?)'\]}
      lazy_images = {}
      doc.css('script').each do |script|
        match = script.content.match(img_with_id_regex)
        next unless match

        id = match[2]
        src = decode_hex(match[1])
        lazy_images[id] = src
      end
      lazy_images
    end

    def decode_hex(str)
      str.gsub(/\\x([0-9A-Fa-f]{2})/) { [Regexp.last_match(1)].pack('H2') }
    end

    def collect_artworks
      artworks = []
      doc.css(ARTWORK_CSS_CLASS).each do |artwork|
        artwork.css('a').each do |link|
          artworks << collect_artwork(link)
        end
      end
      artworks
    end

    def collect_artwork(link)
      artwork = { 'link' => "https://www.google.com#{link['href']}", 'name' => link.css(NAME_CSS_CLASS).text,
                  'image' => collect_image(link) }
      extensions = collect_extensions(link)
      artwork['extensions'] = extensions unless extensions.nil?
      artwork
    end

    def collect_image(link)
      img = link.css(IMG_CSS_CLASS)[0]
      image_id = img['id']
      lazy_images.key?(image_id) ? lazy_images[image_id] : img['data-src']
    end

    def collect_extensions(link)
      extension = link.css(EXTENSION_CSS_CLASS).text
      [extension] unless extension.empty?
    end
  end

  private_constant :Parser
end
