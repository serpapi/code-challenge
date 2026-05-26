require "nokolexbor"

# Parses inline script tags to build an id-to-base64-image lookup map.
class ImageExtractor
  S_PART  = /var s=(?<q>['"])(?<src>data:image[^'"]+)\k<q>/
  II_PART = /var ii=(?<ids>\[[^\]]+\])/
  PATTERN = /#{S_PART};#{II_PART}/

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

      src = match[:src].gsub('\x3d', "=")
      ids = match[:ids].scan(/['"]([^'"]+)['"]/).flatten

      ids.each { |id| map[id] = src }
    end
  end
end
