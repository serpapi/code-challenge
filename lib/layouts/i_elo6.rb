module Layouts
  # Google carousel layout used for paintings, artworks, and similar knowledge-panel carousels.
  class IELo6
    def item_selector   = ".iELo6"
    def image_selector  = "img[id], img[data-src]"
    def name(node)      = text_nodes(node).first
    def extension(node) = text_nodes(node)[1]

    def link(node)
      href = node.at_css("a")&.attr("href")
      href&.start_with?("/") ? "https://www.google.com#{href}" : href
    end

    private

    def text_nodes(node)
      node.xpath(".//text()[normalize-space()]").map { |t| t.text.strip }.reject(&:empty?)
    end
  end
end
