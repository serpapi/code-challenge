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

  def extract_references
    cards.map do |item|
      binding.pry
    end
  end

  private

  def cards
    @document.css(CARDS_CSS_SELECTOR)
  end

  # TO DO: improve regexp or parse javascript
  def extract_image_data(image_id)
    base64_regexp = /(data:image\/jpeg;base64,(?:[A-Za-z0-9+\/]{4}\n?)*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}x\/9k\\x3d|2Q\\x3d\\x3d))';var ii=\['#{image_id}/
    match_data = base64_regexp.match(html)

    # return first match group
    match_data&.captures&.first
  end

end