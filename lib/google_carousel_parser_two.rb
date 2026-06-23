require "nokolexbor"

class GoogleCarouselParserTwo
  def initialize(filepath)
    @filepath = filepath
  end

  def parse
    html_content = File.read(@filepath)
    doc = Nokolexbor::HTML(html_content)
    images_map = extract_script_images(doc)

    candidates = doc.css("a[href*='/search?']").select do |a|
      a.css("img").any? && a.text.strip.length.positive?
    end

    ancestor_counts = candidates.each_with_object(Hash.new(0)) do |item, counts|
      item.ancestors.each { |ancestor| counts[ancestor.path] += 1 }
    end

    carousel_container = candidates.first&.ancestors&.find do |ancestor|
      ancestor_counts[ancestor.path] == candidates.size
    end

    if carousel_container
      header_text = find_nearest_header(carousel_container)
      category_key = header_text.split.last.downcase if header_text
    end

    items = candidates.map do |a|
      text_nodes = a.css("::text").reject { |t| t.text.strip.empty? }

      name = text_nodes.first&.text&.strip

      href = a["href"]
      link = href.start_with?("/") ? "https://www.google.com#{href}" : href

      extensions = text_nodes.size > 1 ? text_nodes[1..-1].map { |t| t.text.strip } : []

      img_node = a.css("img").first
      image = images_map[img_node["id"]] || img_node["data-src"] if img_node

      {
        "name" => name,
        "link" => link,
        "extensions" => extensions,
        "image" => image
      }
    end

    category_key ? { category_key => items } : {}
  end

  private

  def extract_script_images(doc)
    map = {}

    doc.css("script").each do |script|
      code = script.text
      next unless code.include?("base64")

      image_data_match = code.match(/var\s+s\s*=\s*['"]([^'"]+)['"]/)
      image_ids_match = code.match(/var\s+ii\s*=\s*\[([^\]]+)\]/)
      next unless image_data_match && image_ids_match

      base64_data = unescape_javascript_string(image_data_match[1])
      image_ids = image_ids_match[1].scan(/['"]([^'"]+)['"]/).flatten

      image_ids.each do |id|
        map[id] = base64_data
      end
    end

    map
  end

  def unescape_javascript_string(str)
    # Convert hex escapes (like \x3d to = and \x2f to /)
    str = str.gsub(/\\x([0-9a-fA-F]{2})/) { |m| $1.hex.chr }

    # Remove escaped forward slashes (convert \/ to /)
    str.gsub("\\/", "/")
  end

  def find_nearest_header(node)
    curr = node

    while curr
      headings = curr.parent&.css("h2, h3, [role='heading'], [data-attrid='title']")
      header = headings&.find { |h| !h.text.strip.empty? }
      return header.text.strip if header
      curr = curr.parent
    end

    nil
  end
end
