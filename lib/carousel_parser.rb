require "json"
require "nokogiri"

class CarouselParser
  HOSTNAME = "https://www.google.com".freeze

  def initialize(html_string:)
    @html_string = html_string
  end

  def call
    carousel_selector = "div.appcenter.gic g-scrolling-carousel div"
    carousel = root.css(carousel_selector).xpath("./div")

    carousel_items = carousel.xpath("./div")
    items = carousel_items.map(&method(:parse_item))

    { categories.last.downcase => items }
  end

  private

  attr_reader :html_string

  def categories
    heading = root.css("div[role='heading']")
    heading.css("span").map { |span| span.attributes["data-elabel"]&.value }.compact
  end

  def parse_item(item)
    a = item.css("a.klitem")
    extensions = [a.css("div.klmeta").text]
    extensions = nil if extensions == [""]

    img = a.css("img")
    img_id = img.attribute("id").value

    image_js_snippet = image_sources_from_script.find { |snippet| snippet.include?(img_id) }
    base64_image_regex = /(data:image\/.+)';\s*var [a-z]+\s*=\s*\['#{img_id}'\]/
    base64_image = unescape(image_js_snippet[base64_image_regex, 1]) if image_js_snippet

    parsed_item = {
      "name" => a.attribute("aria-label").value,
      "link" => "#{HOSTNAME}#{a.attribute('href').value}",
      "image" => base64_image
    }
    parsed_item["extensions"] = extensions if extensions

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

  # appbar wraps the entire carousel
  def root
    @root ||= html.css("#appbar")
  end

  # TODO: might be a lib that does this more robustly/safely/etc
  def unescape(string)
    string.gsub("\\", "")
  end
end
