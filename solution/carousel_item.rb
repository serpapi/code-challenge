class CarouselItem
  GOOGLE_ORIGIN  = "https://www.google.com".freeze
  NAME_CSS       = 'a'.freeze
  EXTENSIONS_CSS = '.ellip.klmeta'.freeze
  LINK_CSS       = 'a'.freeze
  IMAGE_CSS      = '.klzc > .klic > g-img > img'.freeze

  attr_reader :name, :extensions, :link, :image

  def initialize(carousel_item_html)
    @name       = parse_name(carousel_item_html)
    @extensions = parse_extensions(carousel_item_html)
    @link       = parse_link(carousel_item_html)
    @image      = parse_image(carousel_item_html)
  end

  def to_h
    # omitting the extensions key when there are no extensions as in code-challenge/files/expected-array.json
    {
      name: @name,
      link: @link,
      image: @image
    }.merge(@extensions.empty? ? {} : { extensions: @extensions })
  end

  private

  def parse_name(carousel_item_html)
    if carousel_item_html.name == NAME_CSS
      carousel_item_html.attributes['aria-label']&.value
    else
      carousel_item_html.css(NAME_CSS).first.attributes['aria-label']&.value
    end
  end

  def parse_extensions(carousel_item_html)
    carousel_item_html.css(EXTENSIONS_CSS).map do |extension_element|
      extension_element.children.first.text
    end
  end

  def parse_link(carousel_item_html)
    path_and_query = link_path_and_query(carousel_item_html)

    URI.join(GOOGLE_ORIGIN, path_and_query).to_s unless path_and_query.nil?
  end

  def link_path_and_query(carousel_item_html)
    if carousel_item_html.name == LINK_CSS
      carousel_item_html.attributes['href']&.value
    else
      carousel_item_html.css(LINK_CSS).first.attributes['href']&.value
    end
  end

  def parse_image(carousel_item_html)
    parsed_image = carousel_item_html.css(IMAGE_CSS).first.attributes['src']&.value

    # code-challenge/files/expected-array.json had the Base64 '='s padding converted to 'x3d's
    # this should replicate that, but didn't find an exact reason as to why.
    parsed_image.sub(/(=*)$/) { |match| 'x3d' * match.length } unless parsed_image.nil?
  end
end
