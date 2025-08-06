# frozen_string_literal: true

# Parses a nokogiri html object into an array of carousel items (hashes)
class CarouselParser
  def initialize(html)
    @html = html
  end

  def call
    items = carousel_items
    items.map { |item| process_item(item) }
  end

  private

  attr_reader :html

  def carousel_items
    div = carousel_division
    div.css('a')
  end

  def process_item(item)
    {
      name: name(item),
      extensions: extensions(item),
      link: link(item),
      image: image(item)
    }
  end

  def name(item)
    item.at_css('div').children.first.text
  end

  def extensions(item)
    item.at_css('div').children[1..].map(&:text)
  end

  def link(item)
    item['href']
  end

  def image(item)
    image_elem = item.css('img')
    image_id = image_elem.first['id']

    if image_id
      load_image_from_script(image_id)
    else
      load_image_from_data_src(image_elem)
    end
  end

  def load_image_from_script(image_id)
    script = script_tags.select { |scr| scr.text.include?(image_id) }
    extract_image(script)
  end

  def extract_image(script)
    script.first.text[/s='(.*?)';/, 1]
  end

  def load_image_from_data_src(image_elem)
    image_elem.first['data-src']
  end

  def script_tags
    @script_tags ||= html.css('script')
  end

  def carousel_division
    html.at_css('div[data-attrid^="kc:/"]')
  end
end
