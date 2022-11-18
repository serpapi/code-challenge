require 'nokogiri'
require_relative './artwork.rb'

class ArtworksParser
  attr_reader :doc

  def initialize(path)
    @doc = File.open(path) { |f| Nokogiri::HTML(f) }
  end

  def run
    paintings_nodes.map do |node|
      Artwork.new(
        name: name(node),
        extensions: extensions(node),
        link: link(node),
        image: image(node),
      )
    end
  end

  private

  def paintings_nodes
    carousel_area_node.css('a.klitem')
  end

  def carousel_area_node
    doc.css('.klcc')
  end

  def name(target)
    target['aria-label'].encode("iso-8859-1").force_encoding("utf-8")
  end

  def image(target)
    img = target.at_css('img')
    images_srcs[img['id']] || img['src']
  end

  def link(target)
    "https://www.google.com#{target['href']}"
  end

  def extensions(target)
    Array(target.at_css('.klmeta')&.text)
  end

  def images_srcs
    @images_srcs ||= begin
      js_content = doc.css('script').map(&:text).join
      sanitizer = lambda { |x| x.gsub("\\", "") }
      imgs = js_content
        .scan(/var s='(data:image\/jpeg;base64,\S+)';var ii=\['(\S+)'\];/)
        .map { |m| [m.last, sanitizer.call(m.first)] }
      Hash[imgs]
    end
  end
end
