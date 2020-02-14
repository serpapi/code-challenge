require 'nokogiri'

class ArtworkExtractor

  attr_reader :document

  CARDS_CSS_SELECTOR = 'a.klitem'
  BASE_URL = 'https://www.google.com'

  def initialize(file)
    @document = Nokogiri::HTML.parse(file)
  end

  def html
    @document.inner_html
  end

  def extract_names
    name_attribute = 'aria-label'
    cards.map {|item| item[name_attribute] }
  end

  def extract_links
    link_attribute = 'href'
    cards.map {|item| "#{BASE_URL}#{item[link_attribute]}" }
  end

  def extract_images
    cards.map do |item|
      extract_image_data(item.at_css('g-img img')['id'])
    end
  end

  private

  def cards
    @document.css(CARDS_CSS_SELECTOR)
  end

  def extract_image_data(image_id)
    base64_regexp = /(data:image\/jpeg;base64,(?:[A-Za-z0-9+\/]{4}\n?)*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=)?)2Q\\x3d\\x3d';var ii=\[/
    # return first match group
    base64_regexp.match(html)[1]
  end

end