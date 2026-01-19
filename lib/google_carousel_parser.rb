require 'nokogiri'

class GoogleCarouselParser
  attr_reader :html

  def initialize(html)
    @html = Nokogiri::HTML(html)
  end

  def call
    html.css('div[data-attrid="kc:/visual_art/visual_artist:works"] a').map do |link|
      parse_link(link)
    end
  end

  private

  def parse_link(link)
    img_attrs = link.css('img').first.attributes
    name = img_attrs['alt'].value
    extensions = link.text.gsub(name, '')
    img_src = img_attrs.key?('id') ? image_sources[img_attrs['id'].value] : img_attrs['data-src'].value

    attrs = {
      'link' => "https://www.google.com#{link.attributes['href'].value}",
      'name' => name,
      'image' => img_src
    }
    attrs.merge!('extensions' => [extensions]) unless extensions.empty?
    attrs
  end

  def image_sources
    @image_sources ||= begin
      scripts = html.css('script').map(&:text).select { _1.include?('_setImagesSrc') }
      scripts.each_with_object({}) do |script, acc|
        src, id = script.match(/.*(data:image.*)';.*\['(\w*)'\];/)&.captures
        acc[id] = replace_js_escape_sequences(src) if src && id
      end
    end
  end

  def replace_js_escape_sequences(src)
    src.gsub(/\\x([0-9a-fA-F]{2})/) { |match| match[2..-1].hex.chr }
  end
end
