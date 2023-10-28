require "json"
require "nokogiri"

class CarouselParser
  HOSTNAME = "https://www.google.com".freeze

  def initialize(html_string:)
    @html_string = html_string
  end

  def call
    carousel_items = root.css(".klitem")
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
    extensions = [item.css("div.klmeta").text]
    extensions = nil if extensions == [""]

    img = item.css("img")
    img_id = img.attribute("id").value

    image_js_snippet = image_sources_from_script.find { |snippet| snippet.to_s.include?(img_id) }.to_s
    base64_image_regex = /var s='(data:image\/[^;]+;base64,\S+)';var ii=\['#{img_id}'\]/

    base64_image = image_js_snippet ? unescape(image_js_snippet[base64_image_regex, 1]) : nil

    anchor = item.name == "a" ? item : item.parent

    parsed_item = {
      "name" => item.css(".kltat").text,
      "link" => "#{HOSTNAME}#{anchor.attribute('href').value}",
      "image" => base64_image
    }
    parsed_item["extensions"] = extensions if extensions

    parsed_item
  end

  def image_sources_from_script
    @image_sources_from_script ||= html
      .css("script")
      .select { |snippet| snippet.to_s.include?("data:image") }
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
    string&.gsub("\\", "")
  end
end
