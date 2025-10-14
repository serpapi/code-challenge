require "nokogiri"
require "uri"

module SerpapiChallenge
  # Parses a saved Google SERP for the "ArtistToArtworks" module and similar carousels.
  # Output: { "artworks" => [ { "name", "extensions"[], "link", "image" } ] }
  class Parser
    GOOGLE_ORIGIN = "https://www.google.com".freeze
    # before:
    # YEAR_RE = /\b(1[5-9]\d{2}|20\d{2})\b/
    # after:
    YEAR_RE = /(?<!\d)(1[5-9]\d{2}|20\d{2})(?!\d)/

    def parse_file(path)
      html = File.read(path, encoding: "UTF-8")
      parse_html(html)
    end

    def parse_html(html)
      doc = Nokogiri::HTML(html)
      items = []

      # Strategy A: look near the script blob that mentions ArtistToArtworks
      items += extract_from_artist_to_artworks(doc)

      # Strategy B: fallback — any anchors that contain <img> and plausible SERP href
      items = extract_from_anchors_with_images(doc) if items.empty?

      # Normalize + de-duplicate by [name, link]; keep only embedded images
      seen = {}
      artworks = items.map { |x| normalize_item(x) }
                      .select { |x| x["name"] && x["link"] }
                      .reject { |x| x["image"] && !inline_image?(x["image"]) }
                      .each_with_object([]) do |h, acc|
                        key = [h["name"], h["link"]].join("||")
                        next if seen[key]
                        seen[key] = true
                        acc << h
                      end

      { "artworks" => artworks }
    end

    private

    def inline_image?(src)
      return false if src.nil?
      src.start_with?("data:image/")
    end

    def absolute(href)
      return nil if href.nil? || href.empty?
      if href.start_with?("http://", "https://")
        href
      else
        URI.join(GOOGLE_ORIGIN, href).to_s
      end
    rescue
      nil
    end

    def clean_title(text)
      return nil if text.nil?
      text.to_s.gsub(/\s*[-–]\s*Vincent van Gogh\s*$/i, "").strip
    end

    # Pull a year-like token (for extensions) from nearby text.
    def find_extensions_near(node)
      # Collect text from: the node itself, its image alt, aria-label,
      # up to 2 preceding/following siblings, and 2 ancestor levels + their near siblings.
      buckets = []

      # self
      buckets << node["aria-label"]
      if (img = node.at_css("img"))
        buckets << img["alt"]
      end
      buckets << node.text

      # siblings near the anchor
      buckets += node.xpath("./following-sibling::*[position()<=2] | ./preceding-sibling::*[position()<=2]")
                    .map { |n| [n["aria-label"], n.at_css("img")&.[]("alt"), n.text] }
                    .flatten

      # parents (up to 2 levels) and their close siblings
      parent = node.parent
      2.times do
        break unless parent
        buckets << parent["aria-label"]
        buckets << parent.text
        buckets += parent.xpath("./following-sibling::*[position()<=2] | ./preceding-sibling::*[position()<=2]")
                        .map { |n| [n["aria-label"], n.at_css("img")&.[]("alt"), n.text] }
                        .flatten
        parent = parent.parent
      end

      text = buckets.compact.join(" ")
      puts "text: #{text}"
      years = text.scan(YEAR_RE).flatten.uniq
      years.empty? ? [] : [years.first]
    end


    def extract_from_artist_to_artworks(doc)
      items = []
      target_script = doc.css("script").find { |s| s.text.include?("ArtistToArtworks") }
      root = target_script ? target_script.parent : doc

      root.css("a").each do |a|
        next unless a.at_css("img")
        href = a["href"].to_s
        next if href.empty?
        next unless href.start_with?("/search", "/imgres") || href.start_with?("http")

        img = a.at_css("img")
        title = a["aria-label"] || img&.[]("alt") || a.text
        title = clean_title(title)
        next if title.nil? || title.empty?

        items << {
          "name" => title,
          "extensions" => find_extensions_near(a),
          "link" => absolute(href),
          "image" => img&.[]("src")
        }
      end
      items
    end

    def extract_from_anchors_with_images(doc)
      items = []
      doc.css("a").each do |a|
        next unless a.at_css("img")
        href = a["href"].to_s
        next if href.empty?
        next unless href.start_with?("/search", "/imgres") || href.start_with?("http")

        img = a.at_css("img")
        title = a["aria-label"] || img&.[]("alt") || a.text
        title = clean_title(title)
        next if title.nil? || title.empty?

        items << {
          "name" => title,
          "extensions" => find_extensions_near(a),
          "link" => absolute(href),
          "image" => img&.[]("src")
        }
      end
      items
    end

    def normalize_item(h)
      {
        "name" => clean_title(h["name"]),
        "extensions" => Array(h["extensions"]).compact,
        "link" => absolute(h["link"] || ""),
        "image" => h["image"]
      }
    end
  end
end