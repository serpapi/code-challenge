class ItemListExtractor
  require "nokogiri"
  require "open-uri"

  KNOWLEDGE_CARDS_DATA_ATTR_IDS = [
    "kc:/visual_art/visual_artist:works", # Artworks
    "kc:/book/author:books only", # Books
    "kc:/people/person:movies", # Movies
  ]

  def initialize(url)
    @doc = Nokogiri::HTML(URI.open(url))
  end

  def extract
    find_knowledge_card_div.xpath(".//a").map do |anchor|
      name, extensions = extract_name_and_extensions(anchor)
      {
        name:,
        extensions:,
        link: extract_link(anchor),
        image: extract_image(anchor)
      }.compact
    end
  end

  private

  def find_knowledge_card_div
    knowledge_card_xpath_selector = "//div[" + KNOWLEDGE_CARDS_DATA_ATTR_IDS.map{ |id| "@data-attrid='#{id}'" }.join(" or ") + "]"
    @doc.at_xpath(knowledge_card_xpath_selector)
  end

  def extract_link(anchor)
    anchor.attribute("href").value
  end

  def extract_image(anchor)
    src = anchor.at_xpath(".//img").attribute("src")
    src ? src.value : nil
  end

  def extract_name_and_extensions(anchor)
    # This "extra div" has all info right bellow the image
    extra_info = anchor.at_xpath(".//div[last()]").children

    # The first child of "extra div" is item's name.
    name = extra_info.first.text

    # The other children (after name) of "extra div" are the extensions and the first one is the year,
    # So we remove the first one and get the rest.
    extensions = extra_info.children.drop(1).map do |div|
      !div.content.empty? ? div.content : nil
    end.compact

    [name, extensions]
  end
end
