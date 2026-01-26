require 'nokogiri'
require_relative 'carousel_item_extractor'

class CarouselScraper

  def initialize(html)
    @raw_html = html
    @document = Nokogiri::HTML(html)
  end

  def extract
    { section_key => carousel_items }
  end

  private

  def section_key
    selected_tab = @document.at_css('[role="tab"][aria-selected="true"]')
    return 'results' unless selected_tab

    label = selected_tab.text.gsub(/\s+/, ' ').strip.downcase

    label.empty? ? 'results' : label
  end

  def carousel_items
    items = []
    item_extractor = CarouselItemExtractor.new(@raw_html)

    carousel_item_links(@document).each do |link|
      next unless item_extractor.carousel_item_link?(link)

      item = item_extractor.extract(link)
      items << item if item
    end

    items
  end

  def carousel_item_links(container)
    kc_container_nodes = container.css('[data-attrid^="kc:/"]')
    kc_container_nodes = container.css('[data-attrid*="kc:/"]') if kc_container_nodes.empty?

    carousel_container = kc_container_nodes.max_by { |node| node.css('a[href*="stick="]').length }
    (carousel_container || container).css('a[href*="stick="]').to_a
  end
end
