require 'nokogiri'
require 'json'
require 'pry'

module CarouselScraper
  class Scraper

    BASE64_PREFIX = "data:image/jpeg;base64"
    IMAGE_PATTERN = /var s='data:image\/jpeg;base64,(.*?)';var ii=\['(.*?)'\];/

    def initialize(html)
      @doc = Nokogiri::HTML(html)
    end

    def parse_items
      carousel_item_nodes = @doc.css('g-scrolling-carousel a')
      encoded_images = fetch_encoded_images

      carousel_item_nodes.map do |node|
        parser = CarouselItemParser.new(node, encoded_images)
        parser.transform
      end.compact
    end

    def save_to_json_file(filename, key_name = nil)
      items = parse_items

      items_json = if key_name
        { key_name => items.map(&:as_json) }
      else
        items.map(&:as_json)
      end

      File.write(filename, JSON.pretty_generate(items_json))
    end

    private

    def fetch_encoded_images
      scripts = @doc.css('script').map(&:text)
      image_scripts = scripts.select { |s| s.include?(BASE64_PREFIX) }

      image_data = {}
      matches = []
      # Find all encoded image matches
      image_scripts.each do |script|
        matches += script.scan(IMAGE_PATTERN)
      end
      # Iterate over the matches and populate the hash
      matches.each do |encoded_data, id|
        image_data[id] = "#{BASE64_PREFIX},#{encoded_data}"
      end

      image_data
    end
  end
end
