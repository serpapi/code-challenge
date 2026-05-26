module Layouts
  # Google carousel layout used for movies and filmography carousels.
  # The item is the anchor itself — name comes from aria-label, year from last .FozYP.
  class KlitemTr
    def item_selector   = "a.klitem-tr"
    def image_selector  = "img.VeBrne"
    def name(node)      = node.attr("aria-label")
    def extension(node) = node.css(".FozYP").last&.text
    def link(node)      = node.attr("href")
  end
end
