require 'nokogiri'
require 'json'

class Parser
  def initialize(path = "files/van-gogh-paintings.html")
    text = File.read(path)
    @document = Nokogiri::HTML(text)
  end

  Item = Struct.new(:name, :extensions, :image, :url)

  def carousel
    @carousel ||= @document.xpath('//g-scrolling-carousel/div/div/div/a')
  end

  # @return [Array<Item>]
  def extract_metadata
    # extract the metadata present for the various carousel items
    # and remove the parens from the dates
    @extract_metadata ||= carousel.map do |item|
      search_url = item.attributes['href'].value
      # the hash with the image path can either be indexed by the key "data-src" OR by "data-key",
      # so we sidestep the issue and only ask for the values
      image = item.xpath('.//div/div/g-img/img').first.attributes.values.first.value
      name = item.attributes['title'].value.tr("()", "")
      # values[0] contains the "name" of the item, values[1] contains the date (or nil)
      values = name.split(/(\d+)/).map(&:strip)
      Item.new(values[0], [values[1]], image, search_url)
    end
  end

  # @return [String]
  def result
    extract_metadata.map do |item|
      { name: item.name, extensions: item.extensions, link: item.url, image: item.image }
    end.to_json
  end
end
