module Layouts
  # Google carousel layout used for paintings, artworks, and similar knowledge-panel carousels.
  class IELo6
    def item_selector   = ".iELo6"
    def image_selector  = "img.taFZJe"
    def name(node)      = node.at_css(".pgNMRc")&.text
    def extension(node) = node.at_css(".cxzHyb")&.text

    def link(node)
      href = node.at_css("a")&.attr("href")
      href&.start_with?("/") ? "https://www.google.com#{href}" : href
    end
  end
end
