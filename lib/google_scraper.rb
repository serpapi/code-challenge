# frozen_string_literal: true

require "nokolexbor"
require_relative "./carousel_item"

class GoogleScraper
  # initialize the document and extract the script tag
  def initialize(path_to_html_file)
    @document = File.open(path_to_html_file) { |f| Nokolexbor::HTML(f) }
    @script = extract_script_tag
  end

  # scrape the carousel items
  def scrape
    artworks = []

    carousel = @document.at(".EDblX")
    carousel.css(".klitem-tr").each do |item|
      carousel_item = parse_item(item)

      artworks << carousel_item.to_h
    end

    {"artworks" => artworks}
  end

  private

  # extract the script tag containing the image data
  def extract_script_tag
    @document.css('script[nonce="lOsRZRlq+Dr1LlZhVtLxFg=="]').find { |script| script.text.include?("_setImagesSrc") }&.text
  end

  # parse the carousel item
  def parse_item(item)
    CarouselItem.new(
      name: item.attr("data-entityname") || item.attr("title") || item.children.first.css(".kltat").text,
      extensions: item.children.first.css(".ellip").text.empty? ? [] : [item.children.first.css(".ellip").text],
      link: item.attr("href") || "https://www.google.com" + item.children.first.attr("href"),
      image: scrape_image(item)
    )
  end

  # determine the correct way to scrape the image based on caroseul version
  def scrape_image(item)
    if (image = item.children.first.css("img")) && image.attr("src")&.value
      if image.attr("src").value.include?("data:image/gif")
        extract_image_data(image.attr("id").value)
      else
        image.attr("src").value
      end
    else
      item.css("img").attr("src")&.value || nil
    end
  end

  # parse the javascript and match the image id to the image source data
  def extract_image_data(image_id)
    regexp = /data\S*';var ii=\['#{image_id}'\]/
    # "data:image/jpeg;base64,/9j/4AAQSkZJRgAB...sbgj//2Q\\x3d\\x3d';var ii=['dimg_89']"
    image_data = @script[regexp]
    return nil if image_data.nil?

    # "data:image/jpeg;base64,/9j/4AAQSkZJRgAB...sbgj//2Q\\x3d\\x3d"
    image_data = image_data[0..image_data.index("';var ii=['#{image_id}']") - 1]
    # "data:image/jpeg;base64,/9j/4AAQSkZJRgAB...sbgj//2Qx3dx3d"
    image_data.gsub('\\x3d', "x3d")
  end
end
