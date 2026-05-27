require "nokolexbor"

# Parses inline script tags to build an id-to-base64-image lookup map.
class ImageExtractor
  S_PART  = /var s=(?<q>['"])(?<src>data:image[^'"]+)\k<q>/
  II_PART = /var ii=(?<ids>\[[^\]]+\])/

  def initialize(doc)
    @map = build(doc)
  end

  def [](id)
    @map[id]
  end

  private

  def build(doc)
    doc.css("script").each_with_object({}) do |script, map|
      text     = script.text
      s_match  = text.match(S_PART)
      ii_match = text.match(II_PART)
      next unless s_match && ii_match

      src = s_match[:src].gsub('\x3d', "=")
      ids = ii_match[:ids].scan(/['"]([^'"]+)['"]/).flatten

      ids.each { |id| map[id] = src }
    end
  end
end
