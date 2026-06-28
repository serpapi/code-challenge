# frozen_string_literal: true

require 'json'
require 'nokogiri'

# this is a more generalized parser for any KP html with a carousel
class KnowledgePanelCarouselParser
  class ParseError < StandardError; end

  def parse(html)
    @doc = Nokogiri::HTML(html)
    @encoded_images_hash = encoded_images
    @kp_key = key

    raise ParseError, 'Knowledge Panel overview has no carousel' if @kp_key == 'overview'

    kpanel = @doc.at_css('.kp-wholepage')
    raise ParseError, 'No Knowledge Panel was found' unless @kp_key && kpanel

    # carousel is kc: block with the most items
    # link-rows need 2+ items. if we don't have that use grid tiles
    blocks = kpanel.css('[data-attrid^="kc:"]')
    blocks = [kpanel] if blocks.empty?
    nodes = blocks.map do |block|
      rows = link_row_items(block)
      rows.size >= 2 ? rows : grid_tile_items(block)
    end.max_by(&:size)

    raise ParseError, 'No carousel found in Knowledge Panel' if nodes.empty?

    kp_items = nodes.map { |node| item_attrs(node) }

    { @kp_key => kp_items }.to_json
  end

  private

  # scrapes encoded jpegs with id and builds a hash
  def encoded_images
    @doc.css('script').each_with_object({}) do |script, images|
      text = script.text

      content_match = text.match(%r{var s='(data:image/jpeg;base64,/[0-9a-zA-Z].+?)';})
      next unless content_match

      id_match = text.match(/var ii=\['([a-zA-Z0-9_].+?)'\]/)
      next unless id_match

      # decode js hex escapes for base64 padding
      content = content_match[1].gsub(/\\x([0-9a-fA-F]{2})/) { [Regexp.last_match(1)].pack('H*') }

      images[id_match[1]] = content
    end
  end

  # the given html has our array name in a different place than 2026 results, so this assures backwards compatibility
  def key
    kp_key = @doc.at_css('[role="tab"][aria-selected="true"]')&.text
    kp_key ||= @doc.at_css('[role="link"][aria-current="page"]')&.text

    kp_key.downcase if kp_key
  end

  # all link-row items
  def link_row_items(kpanel)
    kpanel.css('a').select { |anchor| anchor.at_css('img') && anchor.css('> div > div').any? }
  end

  # all wp-grid-tile items
  def grid_tile_items(kpanel)
    kpanel.css('wp-grid-tile').filter_map do |tile|
      if tile.parent.name == 'a'
        tile.parent
      else
        tile.at_css('a')
      end
    end
  end

  # defines our api shape
  def item_attrs(node)
    {
      name: name(node),
      image: image(node),
      link: link(node),
      extensions: extensions(node)
    }.compact # only include values that exist, extrapolating from expected-array.json
  end

  # names are in different places depending on carousel variant
  def name(node)
    normalize_text(node.css('> div > div').first&.text) ||
      normalize_text(node.at_css('wp-grid-tile > div:nth-child(2) > div:first-child')&.text)
  end

  # the items under 'show more' generally have data-src and no id, and displayed items have an id
  def image(node)
    img = node.at_css('img')
    return unless img

    data_src = img['data-src']
    return data_src if data_src

    img_id = img['id']
    return @encoded_images_hash[img_id] if img_id

    nil
  end

  def link(node)
    href = node['href']
    return unless href

    "https://www.google.com#{href}"
  end

  # it turns out extensions are an array for a reason, and may have multiple values
  # https://github.com/serpapi/public-roadmap/issues/1892
  def extensions(node)
    lines = node.css('> div > div').map { |d| normalize_text(d.text) }
    lines = node.css('wp-grid-tile > div:nth-child(2) > div').map { |d| normalize_text(d.text) } if lines.empty?

    ext = lines.drop(1).reject(&:empty?)
    ext.empty? ? nil : ext
  end

  # little gotcha with some non-breaking spaces (\u00A0) in the rammstein results, but google likes to keep it weird so we'll normalize in a few places
  def normalize_text(text)
    return if text.nil?

    text.gsub("\u00A0", ' ').strip
  end
end
