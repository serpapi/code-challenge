require "base64"

class CarouselPaintingTileV2
  NAME_PATH = ".//div/div/div[@jsname = 'T3JDGc']".freeze
  EXTENSIONS_PATH = ".//div/div[@class = 'cp7THd']/div[@class = 'FozYP']".freeze
  GOOGLE_IMAGE_PATH = ".//g-img/img".freeze

  def initialize(node, scripts, page_url: 'https://www.google.com')
    @node = node
    @scripts = scripts
    @page_url = page_url
  end

  def to_json
    data&.to_json
  end

  def data
    extensions = @node.xpath(EXTENSIONS_PATH).text
    image_id = @node.xpath(GOOGLE_IMAGE_PATH).attr('id')
    # Need to escape on single quotes. Otherwise, the regex will match more than what we want.
    regex = /{var s='(?<img>[^']+)';var ii=\['#{image_id}'\];/
    image_match = @scripts.match(regex)
    {
      name: @node.xpath(NAME_PATH).text,
      extensions: extensions.empty? ? nil : extensions.split,
      link: @page_url + @node.attr('href'),
      # Need to replace some invalid characters in the image url.
      image: image_match ? image_match[:img].gsub(/\\x3d/, 'x3d') : nil
    }
  end
end