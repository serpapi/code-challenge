class MainLayoutExtractor

  def initialize(parser)
    @html_parser = parser
  end

  def extract_cards(html)

    html_dom = get_main_dom(html)

    items = extract_items_dom(html_dom)

    extract_items_content(items, html)

  end

  def extract_item_link(item)
    "https://www.google.com" + item.css('a')[0]["href"]
  end

  def extract_items_content(items, html)
    results = Array.new(items.size) {}

    items.each_with_index do |item, index|

      results[index] = extract_item_attributes(item, html)

    end

    results
  end

  def extract_item_image(item, html)
    # thumbnails are located inside a Javascript code, HTML Parser will not be able to parse it, so, we will use Regex
    # to match the thumbnails with each card.
    img = nil

    if item.css('img')[0]
      img_id = item.css('img')[0]['id']
      match = html.match(/var s='([0-9a-zA-Z:,;+\/\\]*)';var ii=\['#{img_id}'\]/im)

      # Replace `\` to make Base64 image valid.
      unless match.kind_of?(NilClass)
        img = match[1].gsub("\\", "")
      end
    end

    img

  end

  def extract_item_extensions(item)
    extensions = Array.new

    item.css('.ellip.klmeta').each do |extension|
      extensions.append(extension.content)
    end

    extensions
  end

  def extract_item_name(item)
    item.css('.kltat')[0].content
  end

  def extract_items_dom(html_dom)
    html_dom.css('.klitem-tr')
  end

  def get_main_dom(html)
    @html_parser.parse(html)
  end

  def extract_item_attributes(item, html)
    name = extract_item_name(item)

    link = extract_item_link(item)

    extensions = extract_item_extensions(item)

    image = extract_item_image(item, html)

    if extensions.size > 0
      { name: name, extensions: extensions, link: link, image: image }
    else
      { name: name, link: link, image: image }
    end
  end

end
