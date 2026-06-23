# frozen_string_literal: true

require "nokogiri"
require "uri"

# Extracts a Google Knowledge Graph entity carousel (paintings, albums,
# buildings, cast, ...) into a uniform array of:
# `{ name, extensions, link, image }`.
# Resilience: the carousel is located by stable Knowledge Graph schema
# (`data-attrid`) and tile structure. We don't use minified classes,
# `jsname`, or per-request ids, because they are not stable.
class CarouselExtractor
  CAROUSEL_ATTRIDS = [
    "kc:/architecture/architect:designed", # buildings
    "kc:/music/artist:albums",             # albums
    "kc:/tv/tv_program:cast",              # cast
    "kc:/visual_art/visual_artist:works"   # paintings
  ].freeze
  GOOGLE           = "https://www.google.com"
  HEX_ESCAPE       = /\\x([0-9a-fA-F]{2})/ # e.g. \x3d -> "="
  # base64 thumbnails injected by:  var s='data:...';var ii=['<imgid>'];
  THUMBNAIL_SCRIPT = %r{var s='(data:image/[^']*)';\s*var ii=\[([^\]]+)\]}
  private_constant(*constants(false))

  def self.call(html) = new(html).entries

  def initialize(html)
    @doc = Nokogiri::HTML(html)
    @thumbnails = index_inline_thumbnails
  end

  def entries
    return [] unless carousel

    carousel.css("a").filter_map { |anchor| entry_for(anchor) }
  end

  private

  attr_reader :doc, :thumbnails

  def carousel
    @carousel ||= CAROUSEL_ATTRIDS.filter_map do |id|
      doc.at_css(%([data-attrid="#{id}"]))
    end.first
  end

  # name and extensions come from the leaf text divs ([name, *extensions]);
  # name falls back to img@alt. Key order matches expected-array.json so the
  # JSON is identical byte-for-byte.
  def entry_for(anchor)
    image = anchor.at_css("img")
    return unless image && anchor["href"]

    leaves = text_leaves(anchor)
    extensions = leaves.drop(1)

    {
      name: leaves.first || image["alt"],
      **(extensions.any? ? { extensions: extensions } : {}),
      link: URI.join(GOOGLE, anchor["href"]).to_s,
      image: image_for(image)
    }
  end

  # In-page thumbnail, no extra request: script-injected base64
  # for the first tiles, else the lazy gstatic URL in data-src. The
  # 1x1 placeholder gif is skipped.
  def image_for(image)
    src = image["src"]
    src = nil if src&.start_with?("data:image/gif")
    thumbnails[image["id"]] || image["data-src"] || src
  end

  def image_ids(raw_ids)
    raw_ids.scan(/'([^']+)'/).flatten
  end

  # image id => inline base64 thumbnail, parsed from the _setImagesSrc script
  # blocks (each match pairs one data: URI with a list of image ids).
  def index_inline_thumbnails
    thumbnail_matches.each_with_object({}) do |(data_uri, raw_ids), map|
      uri = unescape(data_uri)
      image_ids(raw_ids).each { |id| map[id] = uri }
    end
  end

  def text_leaves(anchor)
    anchor.css("div")
          .reject { |d| d.at_css("div") }
          .map { |d| d.text.strip }
          .reject(&:empty?)
  end

  def thumbnail_matches
    doc.css("script").flat_map { |script| script.text.scan(THUMBNAIL_SCRIPT) }
  end

  # Google escapes characters like "=" as \xNN inside the script string literal.
  def unescape(data_uri)
    data_uri.gsub(HEX_ESCAPE) { Regexp.last_match(1).hex.chr }
  end
end
