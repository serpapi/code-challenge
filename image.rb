class Image

  DOMAIN = 'https://www.google.com'.freeze

  attr_reader :item, :image

  def initialize(item, image)
    @item = item
    @image = image
  end

  def fetch_details
    {
      name: name,
      extensions: extensions,
      link: link,
      image: image
    }
  end

  private

  def name
    item.at_css('.kltat').text
  end

  def extensions
    item.css('.klmeta') ? item.css('.klmeta')&.map(&:text) : nil
  end

  def link
    DOMAIN + item.parent.attributes['href']
  end
end