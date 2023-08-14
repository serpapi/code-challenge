require 'json'
require 'base64'
require 'open-uri'
require_relative '../carousel_parser'

class KlitemParser < CarouselParser
  def parse
    doc = Nokogiri::HTML(@html)

    collection = { artworks: [] }

    carousel = get_carousel(doc)
    items = get_items(carousel)

    collection[:artworks] = create_collection(items)

    puts collection[:artworks][0]

    # Return an array containing the extracted data
    JSON.pretty_generate(collection)
  end

  private

  def create_collection(items)
    super
  end

  def get_carousel(doc)
    doc.css('g-scrolling-carousel')
  end

  def get_items(carousel)
    # Select every a-tag containing the substring klitem
    carousel.css('a[class*=klitem]')
  end

  def get_item_name(item)
    item.css('*:nth-child(2)').children[0].text.strip
  end

  def get_extensions(item)
    extensions = []
    found_extensions = item.css('*:nth-child(2) > *:nth-child(2)').text.strip

    return nil if found_extensions.length < 1

    extensions << found_extensions
    extensions
  end

  def get_link(item)
    item['href'] ? "https://www.google.com#{item['href']}" : nil
  end

  def get_thumbnail(item)
    thumbnail_link = item.css('img')[0]['data-key']
    return nil unless thumbnail_link

    thumbnail = URI.open(thumbnail_link, 'rb') { |f| f.read }
    encoded_image = Base64.strict_encode64(thumbnail)

    "data:image/jpeg;base64,#{encoded_image}"
  end
end
