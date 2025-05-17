require 'nokogiri'

class ArtworkParser
  # CSS selectors for the various elements we care about
  CSS = {
    card:       'div.iELo6',
    link:       'a',
    title:      '.pgNMRc',
    extensions: '.cxzHyb',
    image:      'img.taFZJe',
    script:     'script'
  }.freeze

  # Regex to pull out:
  #   var s='data:image/...'; var ii=['id1','id2',…]
  SCRIPT_REGEX = /
    var\s+s='(?<data>data:image\/[^']+)';\s*
    var\s+ii=\[(?<ids>[^\]]+)\]
  /x.freeze

  def initialize(html)
    @doc = Nokogiri::HTML(html)
  end

  # Returns a Hash of the form { 'artworks' => [ ... ] }
  def parse
    build_id_data_map

    artworks = @doc.css(CSS[:card]).each_with_object([]) do |card, list|
      link_el = card.at_css(CSS[:link])
      next unless link_el

      title = link_el.at_css(CSS[:title])&.text&.strip

      # optional year/tags
      exts = link_el
               .css(CSS[:extensions])
               .map { |n| n.text.strip }
               .reject(&:empty?)

      # normalize link to absolute URL
      href = link_el['href']
      link = href.start_with?('http') ? href : "https://www.google.com#{href}"

      # pick up the real base64 data or fall back to data-src
      raw_src = nil
      if (img = link_el.at_css(CSS[:image]))
        id = img['id']
        raw_src = @id_to_data[id] if id
        raw_src ||= img['data-src']
      end

      image = raw_src && unescape_js_unicode(raw_src)

      # build the artwork hash, omitting empty keys
      art = { 'name' => title, 'link' => link }
      art['image']      = image unless image.nil?
      art['extensions'] = exts  unless exts.empty?

      list << art
    end

    { 'artworks' => artworks }
  end

  private

  # Scan all <script> tags, pull out the real data-URLs
  # and map each image ID → that URL.
  def build_id_data_map
    @id_to_data = {}

    @doc.css(CSS[:script]).each do |script|
      text = script.text or next
      if (md = SCRIPT_REGEX.match(text))
        url = md[:data]
        # md[:ids] looks like "'id1','id2',…"
        md[:ids].scan(/'([^']+)'/).flatten.each do |img_id|
          @id_to_data[img_id.strip] = url
        end
      end
    end
  end

  # Turn JS "\xHH" escapes into their real characters.
  # e.g. "..."bW7/g//2Q\x3d\x3d" → "bW7/g//2Q=="
  def unescape_js_unicode(str)
    str.gsub(/\\x([0-9A-Fa-f]{2})/) { [$1.to_i(16)].pack('C') }
  end
end
