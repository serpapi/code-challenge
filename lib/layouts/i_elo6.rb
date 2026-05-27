module Layouts
  # Google carousel layout used for paintings, artworks, and similar knowledge-panel carousels.
  class IELo6
    include TextNodes

    def item_selector   = ".iELo6"
    def image_selector  = "img[id], img[data-src]"
    def name(node)      = text_nodes(node).first
    def extension(node) = text_nodes(node)[1]

    def link(node)      = normalize_link(node.at_css("a")&.attr("href"))
  end
end
