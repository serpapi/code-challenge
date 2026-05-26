module Layouts
  # Google carousel layout used for movies and filmography carousels.
  # The item is the anchor itself — name from aria-label, extension by excluding title text nodes.
  class KlitemTr
    def item_selector  = "a.klitem-tr"
    def image_selector = "img[id], img[data-src]"
    def name(node)     = node.attr("aria-label")
    def link(node)     = node.attr("href")

    def extension(node) = text_nodes(node).last

    private

    def text_nodes(node)
      node.xpath(".//text()[normalize-space()]").map { |t| t.text.strip }.reject(&:empty?)
    end
  end
end
