require 'nokogiri'

class GoogleArtworksParser
  def initialize(html: nil)
    @html = html
    @artworks = []
    process
  end

  def get_result
    @artworks
  end

  private

  def process
    return if @html&.empty?

    document = Nokogiri::HTML.parse(@html)
    script_data = document.css('script').text
    artworks_thumbnail = extract_thumbnails script_data
    carousel_element = document.xpath('//g-scrolling-carousel')
    carousel_element.first.css('a[href*="search"]').each do |item|
      artwork = {}
      # new and old version
      artwork['name'] = item['title'] || item['aria-label']
      # clean name: no dates
      artwork['name'] = artwork['name'].gsub(/[\(\)\d]+/, '').strip

      # create array of years
      extensions = item.css('.ellip')&.to_a&.map { |e| e.text.strip }
      # ignore property if empty
      artwork['extensions'] = extensions if extensions.count.positive?

      link = item['href']
      # make sure we have full url
      link = "https://www.google.com#{link}" if link && link.start_with?('/')
      artwork['link'] = link

      # old format
      image = item.xpath('.//g-img/img')
      if image.count.positive?
        image_id = image.first.attr('id')
      else
        # new format if old not found
        image = item.css('img')
        image_id = image.first['id'] if image.count.positive?
      end
      artwork['image'] = artworks_thumbnail[image_id]
      @artworks << artwork
    end
  end

  def extract_thumbnails(script_data)
    thumbnails = {}
    # get all thumbnails and img ids from script tag
    script_data.scan(/('data:image\/jpeg;base64,[^\]]+')/i).flatten.each do |chunk|
      base64_img = chunk.scan(/(data:image\/jpeg;base64,[^']+)/i).flatten.first
      img_id = chunk.scan(/ii=\[(.*)/i).flatten.first.gsub("'", '')
      # unescape unicode codes for '='
      thumbnails[img_id] = base64_img.gsub('/2Q\\x3d\\x3d', '/2Qx3dx3d')
    end
    thumbnails
  end
end
