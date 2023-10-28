require "json"
require "nokogiri"

class CarouselParser
  HOSTNAME = "https://www.google.com".freeze

  def initialize(html_string:)
    @html_string = html_string
  end

  def call
    category = categories.last # artworks

    carousel_selector = "div.appcenter.gic g-scrolling-carousel div"
    carousel = root.css(carousel_selector).xpath("./div")

    carousel_items = carousel.xpath("./div")

    items = carousel_items.map { |item| parse_item(item) }

    { category.downcase => items }
  end

  private

  attr_reader :html_string

  def categories
    heading = root.css("div[role='heading']")
    heading.css("span").map { |span| span.attributes["data-elabel"]&.value }.compact
  end

  def parse_item(item)
    a = item.css("a.klitem")
    extensions = [a.css("div.klmeta").text] # TODO: return real array

    # image
    img = a.css("img")
    img_id = img.attribute("id").value

    # we could probably also execute this js if we really wanted to
    image_js_snippet = image_sources_from_script.find { |snippet| snippet.include?(img_id) }
    base64_image_regex = /(data:image\/.+)';\s*var [a-z]+\s*=\s*\['kximg2'\]/
    base64_image = image_js_snippet[base64_image_regex, 1] if image_js_snippet

    parsed_item = {
      name: a.attribute("aria-label").value,
      link: "#{HOSTNAME}#{a.attribute('href').value}"
    }
    parsed_item[:extensions] = extensions unless extensions.empty?
    parsed_item[:base64_image] = base64_image unless base64_image.nil?

    parsed_item
  end

  def image_sources_from_script
    @image_sources_from_script ||= images_script
                                   .split("function")
                                   .select { |snippet| snippet.include?("data:image") }
  end

  def images_script
    html
      .css("script")
      .find { |s| s.text.include?("function _setImagesSrc") }
      .inner_html
  end

  def html
    @html ||= Nokogiri::HTML(html_string)
  end

  def root
    @root ||= html.css("#appbar")
  end
end
