# frozen_string_literal: true

require 'json'
require 'nokogiri'
require 'uri'

BASE_URL = 'https://www.google.com'

# we're further generalizing beyond the KP parser, by allowing it to act upon more google variations
class GenericGoogleParser
  class ParseError < StandardError; end

  def parse(html)
    @doc = Nokogiri::HTML(html)
    @encoded_images_hash = encoded_images
    @gstatic_image_urls_hash = gstatic_image_urls
    @node_key = kp_key
    nodes = {}

    # NOTE: move kp-specific stuff to a method
    if @node_key
      nodes = nodes_from_kpanel
    else
      appbar = @doc.at_css('.appbar')

      # NOTE: if there isn't an appbar, it's another use case we haven't seen yet, so i will leave room here. for now, error if it isn't there
      raise ParseError, 'No appbar found' unless appbar

      nodes = appbar.css('[role="tab"]')

      raise ParseError, 'No tabs found' if nodes.empty?

      # now override the empty key
      @node_key = appbar_key(appbar)
    end

    { @node_key => nodes.map { |node| item_attrs(node) } }.to_json
  end

  private

  # scrapes encoded images with id and builds a hash
  def encoded_images
    @doc.css('script').each_with_object({}) do |script, images|
      text = script.text

      # NOTE: adjusted to handle any image type
      content_match = text.match(%r{var s='(data:image/[^;]+;base64,[^']+)';})
      next unless content_match

      id_match = text.match(/var ii=\['([a-zA-Z0-9_].+?)'\]/)
      next unless id_match

      # decode js hex escapes for base64 padding
      content = content_match[1].gsub(/\\x([0-9a-fA-F]{2})/) { [Regexp.last_match(1)].pack('H*') }

      images[id_match[1]] = content
    end
  end

  # scrapes gstatic image urls and builds another hash
  def gstatic_image_urls
    @doc.css('script').each_with_object({}) do |script, urls|
      text = script.text

      text.scan(/id:\s*'([^']+)'/) do |(id)|
        start = Regexp.last_match.end(0)
        chunk = text[start, 1000]

        src = chunk[%r{data-src=\\?"(https://[^"\\]+)}, 1]
        next unless src

        urls[id] = src.gsub('&amp;', '&')
      end

      urls
    end
  end

  # the given html has our array name in a different place than 2026 results, so this assures backwards compatibility
  def kp_key
    kp_key_text = @doc.at_css('[role="tab"][aria-selected="true"]')&.text
    kp_key_text ||= @doc.at_css('[role="link"][aria-current="page"]')&.text

    kp_key_text.downcase if kp_key_text
  end

  def appbar_key(appbar)
    text = appbar.at_css('[role="heading"]')&.text
    return 'items' unless text

    text.downcase.gsub(/[^a-z0-9\s]/, '').gsub(/\s+/, '-')
  end

  # NOTE: moved KP-specific code to a method
  def nodes_from_kpanel
    raise ParseError, 'Knowledge Panel overview has no carousel' if @node_key == 'overview'

    kpanel = @doc.at_css('.kp-wholepage')

    # NOTE: this error used to check @node_key && kpanel, but now it's here
    raise ParseError, 'No Knowledge Panel was found' unless kpanel

    # carousel is kc: block with the most items
    # link-rows need 2+ items. if we don't have that use grid tiles
    blocks = kpanel.css('[data-attrid^="kc:"]')
    blocks = [kpanel] if blocks.empty?

    nodes = blocks.map do |block|
      rows = link_row_items(block)
      rows.size >= 2 ? rows : grid_tile_items(block)
    end.max_by(&:size)

    raise ParseError, 'No carousel found in Knowledge Panel' if nodes.empty?

    nodes
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
    # NOTE: re-ordered to prioritize aria-label, with title as a last resort
    normalize_text(node['aria-label']) ||
      normalize_text(node.css('> div > div').first&.text) ||
      normalize_text(node.at_css('wp-grid-tile > div:nth-child(2) > div:first-child')&.text) ||
      normalize_text(node['title'])
  end

  # the items under 'show more' generally have data-src and no id, and displayed items have an id
  def image(node)
    img = node.at_css('img')

    # NOTE: if there's no img, there may be a gstatic url
    if img
      data_src = img['data-src']
      return data_src if data_src

      img_id = img['id']
      return @encoded_images_hash[img_id] if img_id

    else
      # NOTE: let's check if the id has a gstatic url?
      a_id = node['id']
      return @gstatic_image_urls_hash[a_id] if a_id && @gstatic_image_urls_hash[a_id]
    end

    nil
  end

  # NOTE: using the more idiomatic approach from https://serpapi.com/blog/web-scraping-with-ruby/
  def link(node)
    href = node&.[]('href')
    return unless href

    URI.join(BASE_URL, href).to_s
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
