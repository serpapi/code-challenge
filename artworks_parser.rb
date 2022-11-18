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
    carousel_area_node.css('a.klitem, a:has(div.klitem)')
  end

  def carousel_area_node
    doc.css('.klcc, g-scrolling-carousel')
  end

  def name(target)
    target['aria-label'].encode("iso-8859-1").force_encoding("utf-8")
  end

  def image(target)
    img = target.at_css('img')
    images_srcs[img['id']] || img['src']
  end

  def link(target)
    if target['href'] =~ /^https:/
      target['href']
    else
      "https://www.google.com#{target['href']}"
    end
  end

  def extensions(target)
    meta_node = target.at_css('.klmeta')
    if meta_node
      Array(meta_node&.text)
    else
      Array(target.xpath('.//*').last&.text)
    end
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
