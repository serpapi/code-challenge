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
    @path = path
    @file = File.open(@path)
    @paintings = []
  end

  def parse
    document.css('.klitem').each.with_index do |painting, idx|
      @paintings << Painting.new(
        name: painting.at_css('.kltat').content,
        extensions: painting.css('.klmeta').map(&:text),
        link: link(painting.attr('href')),
        image: painting.at_css('g-img img').attr(:src) ? images[idx] : nil
      )
    end
  ensure
    @file.close
  end

  private

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
