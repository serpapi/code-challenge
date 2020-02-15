require 'nokogiri'

class ArtworkExtractor

  attr_reader :document

  BASE_URL = 'https://www.google.com'

  def initialize(file)
    @document = Nokogiri::HTML.parse(file)
  end

  def html
    @document.inner_html
  end

  def extract_data
    cards.map do |item|
      {
        name: extract_name(item),
        extensions: extract_extensions(item),
        link: extract_link(item),
        image: extract_image(item),
      }
    end
  end

  private

  def cards
    css_selector = 'a.klitem'
    @document.css(css_selector)
  end

  def extract_name(item)
    name_attribute = 'aria-label'
    item[name_attribute]
  end

  def extract_link(item)
    link_attribute = 'href'
    "#{BASE_URL}#{item[link_attribute]}"
  end

  def extract_image(item)
    extract_image_data(item.at_css('g-img img')['id'])
  end

  def extract_extensions(item)
    item.search('div').last.children.map(&:text)
  end

  # TO DO: improve regexp or parse Javascript
  def extract_image_data(image_id)
    base64_regexp = /(data:image\/jpeg;base64,(?:[A-Za-z0-9+\/]{4}\n?)*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}x\/9k\\x3d|2Q\\x3d\\x3d))';var ii=\['#{image_id}/
    match_data = base64_regexp.match(html)

    # return first match group if there is one
    match_data&.captures&.first
  end

end