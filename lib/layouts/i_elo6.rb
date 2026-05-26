module Layouts
  # Google carousel layout used for paintings, artworks, and similar knowledge-panel carousels.
  class IELo6
    def item_selector  = ".iELo6"
    def image_selector = "img.taFZJe"
    def name(node)     = node.css(".pgNMRc").first&.text
    def extension(node) = node.css(".cxzHyb").first&.text
  end
end
