require 'json'
require 'base64'
require 'open-uri'
require_relative '../carousel_parser'

class KlitemParser2023 < CarouselParser
  def parse
    doc = Nokogiri::HTML(@html)

    collection = { artworks: [] }

    carousel = get_carousel(doc)
    items = get_items(carousel)

    collection[:artworks] = create_collection(items)
    collection
  end

  # Checks if the parser is suitable to the html file
  # Criteria: carousel and items must exist
  def is_suitable
    doc = Nokogiri::HTML(@html)
    carousel = get_carousel(doc)
    items = get_items(carousel)

    items.length and items[0]&.children&.length == 1
  end

  private

  def create_collection(items)
    super
  end

  def get_carousel(doc)
    return nil unless doc.respond_to?(:css)

    doc&.css('g-scrolling-carousel')
  end

  def get_items(carousel)
    # Select every a-tag containing the substring klitem
    carousel&.css('a[class~=klitem-tr]') || []
  end

  def get_item_name(item)
    item&.css('.FozYP')&.children&.[](0)&.text&.strip
  end

  def get_extensions(item)
    extensions = []

    item&.css('.FozYP')&.children&.drop(1)&.each do |element|
      text = element.text.strip
      extensions.push(text) if text.match?(/[a-zA-Z0-9]/)
    end

    return nil if extensions.length < 1

    extensions
  end

  def get_link(item)
    item['href'] ? "#{GOOGLE_DOMAIN}#{item['href']}" : nil
  end

  def get_thumbnail(item)
    thumbnail_link = item&.css('img')&.[](0)&.[]('data-key')
    return nil unless thumbnail_link

    thumbnail = URI.open(thumbnail_link, 'rb') { |f| f.read }
    encoded_image = Base64.strict_encode64(thumbnail)

    "data:image/jpeg;base64,#{encoded_image}"
  end
end
