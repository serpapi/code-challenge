module Layouts
  # Shared selectors for Google's grid-tile carousel component (actors, albums, etc.).
  # Subclasses override item_selector only — Google rotates the wrapper class independently.
  class GridTile
    def image_selector  = "img.d7ENZc"
    def name(node)      = node.at_css(".JjtOHd")&.text
    def extension(node) = node.at_css(".cHaqb")&.text
    def link(node)      = node.at_css("a")&.attr("href")
  end
end
