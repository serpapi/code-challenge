require "nokogiri"
require "uri"

module SerpapiChallenge
  # Parses the saved Google SERP carousel ("ArtistToArtworks") for Van Gogh paintings.
  # Output JSON:
  # { "artworks": [ { "name", "extensions": [year?], "link", "image(data:... or nil)" } ] }
  #
  # Rules:
  # - No network requests
  # - "image" must be an embedded data URL (data:image/...;base64,...) or nil
  # - Prefer the year displayed on the tile; support "jammed" text like "Night1889"
  class Parser
    GOOGLE_ORIGIN  = "https://www.google.com".freeze

    # Year regex that matches 1500–2099 even when glued to letters (e.g., "Night1889")
    YEAR_RE        = /(?<!\d)(1[5-9]\d{2}|20\d{2})(?!\d)/
    # 1×1 transparent gif placeholder (must be rejected)
    PLACEHOLDER_RE = %r{\Adata:image/gif;base64,R0lGODlhAQABA}i
    # Generic data URL (jpeg/jpg/png/webp) seen in inline JS blobs or attributes
    DATA_URL_RE    = /data:image\/(?:jpeg|jpg|png|webp);base64,[A-Za-z0-9+\/=]+/i

    # ---------------- public API ----------------

    def parse_file(path)
      html = File.read(path, encoding: "UTF-8")
      parse_html(html)
    end

    def parse_html(html)
      doc = Nokogiri::HTML(html)

      # 1) Collect candidate items from the ArtistToArtworks area; otherwise general scan
      items = extract_from_artist_to_artworks(doc)
      items = extract_from_anchors_with_images(doc) if items.empty?

      # 2) Normalize early (except image), de-dupe by [name, link]
      seen = {}
      artworks = items.map { |x|
        {
          "name"       => clean_title(x["name"]),
          "extensions" => Array(x["extensions"]).compact,
          "link"       => absolute(x["link"] || ""),
          "image"      => x["image"] # may be nil; we will fill from global data URLs next
        }
      }.select { |h| h["name"] && h["link"] }
       .each_with_object([]) do |h, acc|
          key = [h["name"], h["link"]].join("||")
          next if seen[key]
          seen[key] = true
          acc << h
       end

      # 3) Global pass: collect every embedded base64 image in the whole HTML with byte positions
      data_urls = collect_data_images_with_positions(html)  # [{url:, pos:}, ...]

      # 4) Assign images to artworks deterministically by nearest title occurrence in the raw HTML
      title_pos_cache = Hash.new { |h, k| h[k] = find_all_title_positions(html, k) }
      used = Array.new(data_urls.length, false)
      usage_index = Hash.new(0) # nth occurrence per title as we iterate

      artworks.each do |h|
        # If we already found a local embedded data image, keep it; otherwise fill from global pool
        if !(h["image"] && h["image"].start_with?("data:image/") && !placeholder?(h["image"]) && h["image"].length >= 500)
          title = h["name"].to_s
          occ_list = title_pos_cache[title]
          occ_i = usage_index[title.downcase]
          usage_index[title.downcase] += 1
          anchor_pos = occ_list[occ_i] || occ_list.last

          picked_index = nil
          if anchor_pos
            # Choose nearest unused data URL to the title position
            picked_index = (0...data_urls.length)
                             .reject { |i| used[i] }
                             .min_by { |i| (data_urls[i][:pos] - anchor_pos).abs }
          end
          picked_index ||= (0...data_urls.length).find { |i| !used[i] } # fallback: next unused

          if picked_index
            h["image"] = data_urls[picked_index][:url]
            used[picked_index] = true
          else
            h["image"] = nil
          end
        end
      end

      # 5) Final enforcement: only keep real embedded data URLs; drop placeholders / http(s)
      artworks.each do |h|
        img = h["image"]
        if !(img && img.start_with?("data:image/") && !placeholder?(img) && img.length >= 500)
          h["image"] = nil
        end
      end

      { "artworks" => artworks }
    end

    # ---------------- internals ----------------

    def absolute(href)
      return nil if href.nil? || href.empty?
      return href if href.start_with?("http://", "https://")
      URI.join(GOOGLE_ORIGIN, href).to_s
    rescue
      nil
    end

    def placeholder?(src)
      src && src.match?(PLACEHOLDER_RE)
    end

    def clean_title(text)
      return nil if text.nil?
      text.to_s.gsub(/\s*[-–]\s*Vincent van Gogh\s*$/i, "").strip
    end

    def parse_srcset_list(val)
      return [] if val.nil? || val.empty?
      val.split(",").map { |part| part.strip.split(/\s+/, 2).first }.compact
    end

    def likely_tile_anchor?(a)
      href = a["href"].to_s
      return false if href.empty? || href.include?("/webhp") # skip logo/home/header links
      return false unless href.start_with?("/search", "/imgres") || href.start_with?("http")
      # Carousel tiles usually have these title/year containers around
      a.at_css(".pgNMRc") || a.at_css(".cxzHyb") || a.parent&.at_css(".pgNMRc, .cxzHyb")
    end

    # Prefer the tile's own caption node for the year; then fallback to local text
    def find_extensions_near(a_node)
      re = YEAR_RE

      # 0) Specific caption node used by Google in saved SERPs
      if (n = a_node.at_css(".cxzHyb")) && (yr = n.text[re, 1])
        return [yr]
      end
      if (n = a_node.xpath("./following-sibling::*[contains(@class,'cxzHyb')][1] | ./preceding-sibling::*[contains(@class,'cxzHyb')][1]").first)
        if (yr = n.text[re, 1]); return [yr]; end
      end
      if (n = a_node.parent&.at_css(".cxzHyb")) && (yr = n.text[re, 1])
        return [yr]
      end

      # 1) Self attributes/text
      [a_node["aria-label"], a_node.at_css("img")&.[]("alt"), a_node.text].compact.each do |t|
        if (yr = t[re, 1]); return [yr]; end
      end

      # 2) Immediate siblings
      a_node.xpath("./following-sibling::*[position()<=2] | ./preceding-sibling::*[position()<=2]").each do |sib|
        [sib["aria-label"], sib.at_css("img")&.[]("alt"), sib.text].compact.each do |t|
          if (yr = t[re, 1]); return [yr]; end
        end
      end

      # 3) Two ancestor levels + their close siblings
      parent = a_node.parent
      2.times do
        break unless parent
        [parent["aria-label"], parent.text].compact.each do |t|
          if (yr = t[re, 1]); return [yr]; end
        end
        parent.xpath("./following-sibling::*[position()<=2] | ./preceding-sibling::*[position()<=2]").each do |sib|
          [sib["aria-label"], sib.at_css("img")&.[]("alt"), sib.text].compact.each do |t|
            if (yr = t[re, 1]); return [yr]; end
          end
        end
        parent = parent.parent
      end

      []
    end

    # Nearby <img> elements around the anchor tile
    def imgs_near(a_node)
      (a_node.css("img").to_a +
       a_node.xpath("./following-sibling::*[position()<=2]//img | ./preceding-sibling::*[position()<=2]//img").to_a +
       a_node.xpath("ancestor::*[position()<=2]//img").to_a).uniq
    end

    # Try to find a real embedded data URL close to the tile (attributes/srcset/css)
    def extract_inline_data_image_near(a_node)
      urls = []
      imgs_near(a_node).each do |img|
        %w[src data-src data-lz-src data-deferred-src data-original srcset data-srcset].each do |attr|
          v = img[attr]
          next if v.nil? || v.empty?
          if attr.include?("srcset")
            v.split(",").each { |part| urls << part.strip.split(/\s+/, 2).first }
          else
            urls << v
          end
        end
        # CSS background-image on the <img>
        if (style = img["style"].to_s).match(/background-image\s*:\s*url\(['"]?([^'")]+)['"]?\)/i)
          urls << $1
        end
      end
      # CSS background-image on anchor/parent wrappers
      [a_node, a_node.parent].compact.each do |n|
        if (style = n["style"].to_s).match(/background-image\s*:\s*url\(['"]?([^'")]+)['"]?\)/i)
          urls << $1
        end
      end

      urls = urls.compact.uniq.select { |u| u.start_with?("data:image/") && !placeholder?(u) && u.length >= 500 }
      urls.first # may be nil
    end

    # Collect every embedded data URL in the *entire* raw HTML, with its byte offset.
    # (Filters placeholders and tiny base64 blobs.)
    def collect_data_images_with_positions(html)
      results = []
      html.to_enum(:scan, DATA_URL_RE).each do
        url = Regexp.last_match[0]
        next if url.match?(PLACEHOLDER_RE)
        next if url.length < 500 # filter out tiny noise; adjust threshold if needed
        pos = Regexp.last_match.begin(0)
        results << { url: url, pos: pos }
      end
      results
    end

    # Positions (byte offsets) for all occurrences of a title string in the raw HTML
    def find_all_title_positions(html, title)
      return [] if title.to_s.empty?
      pat = Regexp.new(Regexp.escape(title), Regexp::IGNORECASE)
      poss = []
      html.to_enum(:scan, pat).each { poss << Regexp.last_match.begin(0) }
      poss
    end

    # Build a single item hash from an anchor node
    def make_item_from_anchor(a)
      img = a.at_css("img")
      title = a["aria-label"] || img&.[]("alt") || a.text
      title = clean_title(title)
      return nil if title.nil? || title.empty?

      {
        "name"       => title,
        "extensions" => find_extensions_near(a),
        "link"       => absolute(a["href"]),
        "image"      => extract_inline_data_image_near(a) # may be nil; filled later from global pool
      }
    end

    # Focused extraction around the "ArtistToArtworks" hint
    def extract_from_artist_to_artworks(doc)
      items = []
      target_script = doc.css("script").find { |s| s.text.include?("ArtistToArtworks") }
      root = target_script ? target_script.parent : doc

      root.css("a").each do |a|
        next unless a.at_css("img")
        next unless likely_tile_anchor?(a)
        if (h = make_item_from_anchor(a))
          items << h
        end
      end
      items
    end

    # General fallback extraction if the hint isn't available
    def extract_from_anchors_with_images(doc)
      items = []
      doc.css("a").each do |a|
        next unless a.at_css("img")
        next unless likely_tile_anchor?(a)
        if (h = make_item_from_anchor(a))
          items << h
        end
      end
      items
    end
  end
end
