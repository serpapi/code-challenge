class CarouselArtistTile
  NAME_PATH = ".//div/div[@class = 'WGwSK SoZvjb']"
  GOOGLE_IMAGE_PATH = ".//g-img/img"

  def initialize(node, scripts, page_url: 'https://www.google.com')
    @node = node
    @scripts = scripts
    @page_url = page_url
  end

  def to_json
    data&.to_json
  end

  def data
    if @node.children.empty?
      return nil
    end
    {
      caption: @node.xpath(NAME_PATH).text,
      link: @page_url + @node.attr('href'),
      image: @node.xpath(GOOGLE_IMAGE_PATH).attr('src')&.value
    }
  end
end