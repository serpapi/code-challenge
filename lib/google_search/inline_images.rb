# frozen_string_literal: true

require 'json'

module GoogleSearch
  # Carousel thumbnails are lazy-loaded; inline scripts carry the real
  # image for each img element id. Maps img id -> data URI or URL.
  class InlineImages
    DATA_URI_PATTERN = %r{var s='(data:image/[^']+)';var ii=\[([^\]]+)\]}
    DEFERRED_URL_PATTERN = /google\.ldi=(\{[^{}]*\})/

    def initialize(document)
      @map = build(document)
    end

    def [](id)
      @map[id]
    end

    private

    def build(document)
      document.css('script').each_with_object({}) do |script, map|
        scan_deferred_urls(script.text, map)
        scan_data_uris(script.text, map)
      end
    end

    def scan_data_uris(text, map)
      text.scan(DATA_URI_PATTERN) do |data_uri, ids|
        unescaped = unescape_js(data_uri)
        ids.scan(/'([^']+)'/) { |(id)| map[id] = unescaped }
      end
    end

    # google.ldi is a JSON map of img id -> thumbnail URL, applied by the
    # page's JS once the carousel scrolls into view.
    def scan_deferred_urls(text, map)
      text.scan(DEFERRED_URL_PATTERN) do |(json)|
        map.merge!(JSON.parse(json))
      rescue JSON::ParserError
        nil
      end
    end

    # Base64 padding and other characters arrive JS-escaped (`\x3d` == `=`).
    def unescape_js(string)
      string.gsub(/\\x([0-9a-f]{2})/i) { Regexp.last_match(1).hex.chr }
    end
  end
end
