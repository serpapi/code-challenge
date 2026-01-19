require 'nokolexbor'

class GoogleCarouselParser
  attr_reader :html, :attr_id

  ATTR_ID_REGEX = %r{kc:/\w*/\w*:\w*}

  def initialize(html)
    @attr_id = html.match(ATTR_ID_REGEX).to_a.first
    @html = Nokolexbor::HTML(html)
  end

  def call
    carousel_block = html.at_css("div[data-attrid='#{attr_id}']")
    heading = html.at_css('[role="tab"][aria-selected="true"]')&.text&.downcase || extract_heading(carousel_block)
    data = carousel_block.css('a').map { |el| parse_element(el) }.compact

    { heading => data }
  end

  private

  def parse_element(el)
    img_attrs = el.at_css('img')&.attributes
    return unless img_attrs
    name, *extensions = el.css('::text').map(&:text)
    img_src = img_attrs.key?('id') ? image_sources[img_attrs['id'].value] : img_attrs['data-src'].value

    attrs = { 'link' => construct_link(el), 'name' => name, 'image' => img_src }
    attrs.merge!('extensions' => extensions) unless extensions.empty?
    attrs
  end

  def construct_link(el)
    val = el.attributes['href'].value
    val.start_with?('http') ? val : "https://www.google.com#{val}"
  end

  def extract_heading(carousel)
    heading = carousel.parent.at_css("div[role='heading']")
    return heading.css('::text').last.text.downcase if heading

    extract_heading(carousel.parent)
  end

  def image_sources
    @image_sources ||= begin
      scripts = html.css('script').map(&:text).select { _1.include?('_setImagesSrc') }
      scripts.each_with_object({}) do |script, acc|
        src, id = script.match(/.*(data:image.*)';.*\['([\w-]*)'\];/)&.captures
        acc[id] = replace_js_escape_sequences(src) if src && id
      end
    end
  end

  def replace_js_escape_sequences(src)
    src.gsub(/\\x([0-9a-fA-F]{2})/) { |match| match[2..-1].hex.chr }
  end
end
