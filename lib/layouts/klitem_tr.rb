module Layouts
  # Google carousel layout used for movies and filmography carousels.
  # The item is the anchor itself — name from aria-label, extension is the last text node.
  class KlitemTr
    include TextNodes

    def item_selector   = "a.klitem-tr"
    def image_selector  = "img[id], img[data-src]"
    def name(node)      = node.attr("aria-label")
    def extension(node) = text_nodes(node).last&.match?(/\A\d{4}\z/) ? text_nodes(node).last : nil
    def link(node)      = normalize_link(node.attr("href"))
  end
end
