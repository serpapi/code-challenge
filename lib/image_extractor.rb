require "nokolexbor"

# Parses inline script tags to build an id-to-base64-image lookup map.
class ImageExtractor
  PATTERN = /var s='(data:image[^']+)';var ii=(\[[^\]]+\])/

  def initialize(doc)
    @map = build(doc)
  end

  def [](id)
    @map[id]
  end

  private

  def build(doc)
    doc.css("script").each_with_object({}) do |script, map|
      match = script.text.match(PATTERN)
      next unless match

      src  = match[1].gsub('\x3d', "=")
      ids  = match[2].scan(/'([^']+)'/).flatten

      ids.each { |id| map[id] = src }
    end
  end
end
