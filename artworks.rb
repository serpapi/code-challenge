require "nokogiri"
require "uri"

class Artworks
  BASE_URL = "https://www.google.com"

  def initialize(html)
    @html = html
  end

  def payload
    artworks_doc = doc.css("div[data-attrid='kc:/visual_art/visual_artist:works']")

    {
      artworks: artworks_doc.css('a').map { |a|
        img_payload(a)
      }.compact
    }
  end

  private

  def img_payload(a)
    img = a.at_css("img")
    return unless img

    name = img["alt"]&.strip
    {
      name: name,
      extensions: img_extensions(a, name),
      link: url(a["href"]),
      image: img["data-src"] || deferred_img_srcs[img["id"]]
    }.compact
  end

  def img_extensions(a, name)
    exts = a.xpath(".//text()").map { |t| t.to_s.strip }.reject(&:empty?)
    exts.reject! { |ext| ext == name } if name
    exts.empty? ? nil : exts
  end

  def url(path)
    return unless path

    URI.join(BASE_URL, path).to_s
  end

  def deferred_img_srcs
    @deferred_img_srcs ||= doc.css('a img[data-deferred="1"][id]').reduce({}) do |hash, img|
      img_id = img["id"]
      script = scripts.find { |s| s.text&.include?(img_id) }
      next hash unless script

      encoded_src = script.text[/var s='([^']+)';/, 1]
      next hash unless encoded_src

      hash[img_id] = decode_hex_escapes(encoded_src)
      hash
    end
  end

  def decode_hex_escapes(str)
    str&.gsub(/\\x([0-9a-fA-F]{2})/) { [$1].pack('H*') }
  end

  def doc
    @doc ||= Nokogiri::HTML(@html)
  end

  def scripts
    @scripts ||= doc.xpath("//script")
  end
end
