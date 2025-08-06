# frozen_string_literal: true

class CarouselParser
  def initialize(html)
    @html = html
  end

  def call
    items = get_all_carousel_items
    items.map { |item| process_item(item) }
  end

  attr_reader :html

  def get_all_carousel_items
    div = get_carousel_division
    div.css('a')
  end

  def process_item(item)
    {
      name: name(item),
      extensions: extensions(item),
      link: link(item)
    }
  end

  def name(item)
    item.at_css('div').children.first.text
  end

  def extensions(item)
    item.at_css('div').children[1..].map {|extension| extension.text }
  end

  def link(item)
    item['href']
  end

  def get_carousel_division
    html.at_css('div[data-attrid^="kc:/"]')
  end
end
