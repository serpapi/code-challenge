# frozen_string_literal: true

require "nokolexbor"
require "oj"

class Parser
  def self.parse(file)
    new(file).parse
  end

  attr_reader :doc

  def initialize(file)
    @doc = Nokolexbor::HTML(File.open("files/#{file}"))
    # memoize the script tag to avoid running the xpath query multiple times
    @script_tag = doc.at_xpath("//script[contains(text(), \"var ii=['\")]").content
  end

  def parse
    if doc.css("span[data-elabel]").first
      parse_version1
    elsif doc.css("div#search div[role='heading']").first
      parse_version2
    else
      raise "Unknown version of search result file"
    end
  end

  private

  def parse_version1
    json_root = extract_v1_json_root

    { json_root.to_s => extract_v1_json_content }
  end

  def parse_version2
    json_root = extract_v2_json_root

    { json_root.to_s => extract_v2_json_content }
  end

  def extract_v1_json_root
    to_underscore(doc.css("span[data-elabel]")[1].text)
  end

  def extract_v1_json_content
    doc.css("div.appcenter g-scrolling-carousel a").map do |carrousel_item|
      # Expected format for extensions is optional, so we don't include it in the json if it's empty
      extensions = extract_v1_carousel_item_extensions(carrousel_item)

      item_hash = {
        "name" => extract_v1_carousel_item_name(carrousel_item),
        "link" => extract_v1_carousel_item_link(carrousel_item),
        "image" => extract_carousel_item_image(carrousel_item)
      }
      item_hash["extensions"] = extensions unless extensions.empty?
      item_hash
    end
  end

  def extract_v1_carousel_item_name(carrousel_item)
    carrousel_item.css("div > div > span").map(&:text).join("")
  end

  def extract_v1_carousel_item_extensions(carrousel_item)
    carrousel_item.css("div div:nth-child(2)")&.map(&:text) || []
  end

  def extract_v1_carousel_item_link(carrousel_item)
    "https://www.google.com#{carrousel_item.attr('href')}"
  end

  def extract_carousel_item_image(carrousel_item)
    image_id = carrousel_item.css("img")&.attr("id")
    return unless image_id

    # Since google is running a script to replace the image src, we use a quick hack for performance,
    # instead of running the script. Might be better to run the script and get the image src, but it would
    # be slower but more accurate and less prone to break
    if @script_tag
      match_group = @script_tag.match(/var s='([^']+)';var ii=\['#{image_id}'\];/)
      return match_group[1] if match_group
    end

    carrousel_item.css("img")&.attr("src")&.value
  end

  def extract_v2_json_root
    to_underscore(doc.css("div#search div[role='heading']").first.text)
  end

  def extract_v2_json_content
    doc.css("wp-grid-view a").map do |carrousel_item|
      # Expected format for extensions is optional, so we don't include it in the json if it's empty
      extensions = extract_v2_carousel_item_extensions(carrousel_item)

      item_hash = {
        "name" => extract_v2_carousel_item_name(carrousel_item),
        "link" => extract_v2_carousel_item_link(carrousel_item),
        "image" => extract_carousel_item_image(carrousel_item)
      }
      item_hash["extensions"] = extensions unless extensions.empty?
      item_hash
    end
  end

  def extract_v2_carousel_item_name(carrousel_item)
    carrousel_item.css("wp-grid-tile").text
  end

  def extract_v2_carousel_item_extensions(_carrousel_item)
    []
  end

  def extract_v2_carousel_item_link(carrousel_item)
    carrousel_item.attr("href")
  end

  def to_underscore(string)
    string.gsub(/(.)([A-Z])/, '\1_\2').downcase
  end
end
