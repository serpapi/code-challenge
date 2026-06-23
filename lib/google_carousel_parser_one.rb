require "nokolexbor"

class GoogleCarouselParserOne
  def initialize(filepath)
    @filepath = filepath
  end

  def parse
    html_content = File.read(@filepath)
    doc = Nokolexbor::HTML(html_content)

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

      {
        "name" => name,
        "link" => [link],
        "extensions" => extensions
      }
    end

    category_key ? { category_key => items } : {}
  end

  private

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
