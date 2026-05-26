module Layouts
  # Shared selectors for Google's grid-tile carousel component (actors, albums, etc.).
  # Subclasses override item_selector only — Google rotates the wrapper class independently.
  class GridTile
    def image_selector  = "img[id], img[data-src]"
    def name(node)      = text_nodes(node).first
    def extension(node) = text_nodes(node)[1]
    def link(node)      = node.at_css("a")&.attr("href")

    private

    def text_nodes(node)
      node.xpath(".//text()[normalize-space()]").map { |t| t.text.strip }.reject(&:empty?)
    end
  end
end
