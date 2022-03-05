require 'nokogiri'

class Painting
  attr_reader :name, :link, :image, :extensions

  def initialize(params)
    @name = params[:name]
    @link = params[:link]
    @image = params[:image]
    @extensions = params[:extensions]
  end

  def to_h
    info = { name: name, link: link, image: image }
    info[:extensions] = extensions unless extensions.empty?
    info
  end
end

class GoogleParser
  DEFAULT_FILE_PATH = './files/van-gogh-paintings.html'.freeze

  attr_reader :paintings

  def initialize(path = DEFAULT_FILE_PATH)
    @file = File.open(path)
    @paintings = []
  end

  def parse
    #first = klitems.first
    klitems.each.with_index do |painting, idx|
      @paintings << Painting.new(
        name: painting.attr('aria-label'),
        extensions: select_extensions(painting),
        link: link(painting.attr('href')),
        image: painting.at_css('g-img img').attr(:src) ? images[idx] : nil
      )
    end
  ensure
    @file.close
  end

  private

  def klitems
    document.css('a.klitem') + document.css('a.klitem-tr')
  end

  def select_extensions(node)
    legacy_select = node.css('.klmeta')
    return legacy_select.map(&:text) unless legacy_select.empty?

    node = node.children.last until node.nil? || node.text?
    return [] if node.nil?

    node.parent.children.map(&:text)
  end

  def link(href)
    "https://www.google.com#{href}"
  end

  def document
    @document ||= Nokogiri::HTML(file_content)
  end

  def file_content
    @file_content ||= @file.read
  end

  def images
    @images ||= file_content.scan(%r{var s='(data:image/jpeg;base64,\S+)';}).map { _1[0] }
  end
end
