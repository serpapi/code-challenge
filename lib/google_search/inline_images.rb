# frozen_string_literal: true

module GoogleSearch
  # Carousel thumbnails are lazy-loaded: inline scripts assign base64 data
  # URIs to img element ids. Maps img id -> data URI.
  class InlineImages
    PATTERN = %r{var s='(data:image/[^']+)';var ii=\[([^\]]+)\]}

    def initialize(document)
      @map = build(document)
    end

    def [](id)
      @map[id]
    end

    private

    def build(document)
      document.css('script').each_with_object({}) do |script, map|
        script.text.scan(PATTERN) do |data_uri, ids|
          unescaped = unescape_js(data_uri)
          ids.scan(/'([^']+)'/) { |(id)| map[id] = unescaped }
        end
      end
    end

    # Base64 padding and other characters arrive JS-escaped (`\x3d` == `=`).
    def unescape_js(string)
      string.gsub(/\\x([0-9a-f]{2})/i) { Regexp.last_match(1).hex.chr }
    end
  end
end
