module Layouts
  # Shared selectors for Google's grid-tile carousel component (actors, albums, etc.).
  # Subclasses override item_selector only — Google rotates the wrapper class independently.
  class GridTile
    def image_selector  = "img.d7ENZc"
    def name(node)      = node.css(".JjtOHd").first&.text
    def extension(node) = node.css(".cHaqb").first&.text
    def link(node)      = node.css("a").first&.attr("href")
  end
end
