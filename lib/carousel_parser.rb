require "json"
require "nokogiri"
require "ostruct"

class CarouselParser
  HOSTNAME = "https://www.google.com"

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
    script_with_images = html.css("script").find { |s| s.text.include?(img_id) }.inner_html

    # we could probably also execute this js if we really wanted to
    base64_image_regex = /('data:image\/.+')\;\s*var [a-z]+\s*=\s*\['#{img_id}'\]/
    base64_image = script_with_images[base64_image_regex, 1]

    parsed_item = OpenStruct.new(
      name: a.attribute("aria-label"),
      link: "#{HOSTNAME}#{a.attribute('href')}",
      image: base64_image
    )
    parsed_item.extensions = extensions unless extensions.empty?

    parsed_item
  end

  def html
    @html ||= Nokogiri::HTML(html_string)
  end

  def root
    @root ||= html.css("#appbar")
  end
end
