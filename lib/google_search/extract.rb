# frozen_string_literal: true

require 'json'
require 'nokolexbor'
require_relative 'extracted_result'
require_relative 'inline_images'

module GoogleSearch
  # Extracts knowledge-graph carousel items from a saved Google search
  # results page.
  class Extract
    SEARCH_LINK = %r{\A(?:/|https://www\.google\.[a-z.]+/)search\?}
    BASE_URL = 'https://www.google.com'
    MIN_CAROUSEL_ITEMS = 2

    def initialize(file)
      @html = file.respond_to?(:read) ? file.read : File.read(file)
    end

    def results
      @results ||= parse
    end

    def to_a
      results.map(&:to_h)
    end

    def to_json(*)
      to_a.to_json(*)
    end

    private

    def parse
      document = Nokolexbor::HTML(@html)
      inline_images = InlineImages.new(document)
      carousel_items(document).map { |item| build_result(item, inline_images) }
    end

    # The carousel is the largest group of items linking into a Google
    # search, across the two known layouts: anchors-with-thumbnails grouped
    # under a knowledge-graph div[data-attrid], or div[role=listitem] rows
    # inside a div[role=list].
    def carousel_items(document)
      (anchor_groups(document) + list_groups(document))
        .select { |group| group.length >= MIN_CAROUSEL_ITEMS }
        .max_by(&:length) || []
    end

    def anchor_groups(document)
      document.css('div[data-attrid]').filter_map do |container|
        next if refinement?(container)

        items = search_anchors(container).select { |anchor| anchor.at_css('img') }
        items unless items.empty?
      end
    end

    def list_groups(document)
      document.css('div[role="list"]').filter_map do |container|
        next if refinement?(container)

        items = container.css('div[role="listitem"]').select do |item|
          search_anchors(item).any? && item.at_css('img') && item.at_css('div[role="heading"]')
        end
        items unless items.empty?
      end
    end

    # Search-refinement sections ("people also search for" / drill-downs,
    # data-attrid *sideways*/*downwards*) look like carousels but list
    # related entities, not the page's subject.
    def refinement?(node)
      while node&.element?
        return true if node['data-attrid']&.match?(/sideways|downwards/)

        node = node.parent
      end
      false
    end

    def search_anchors(node)
      node.css('a[href]').select { |anchor| SEARCH_LINK.match?(anchor['href']) }
    end

    def build_result(item, inline_images)
      image_node = item.at_css('img')
      name, extensions = caption_for(item, image_node)
      ExtractedResult.new(
        name: name,
        extensions: extensions,
        link: link_for(item),
        image: image_for(image_node, inline_images)
      )
    end

    def caption_for(item, image_node)
      texts = caption_texts(item)
      name = name_for(item, texts, image_node)
      extensions = texts.reject { |text| name&.include?(text) }
      [name, extensions.empty? ? nil : extensions]
    end

    # Name sources, most reliable first. The anchor's own label carries the
    # full text even when a long name wraps across several caption divs.
    def name_for(item, texts, image_node)
      candidates = [heading_text(item), labeled_name(item), texts.first, image_node['alt']]
      candidates.find { |value| value && !value.empty? }
    end

    def heading_text(item)
      heading = item.at_css('div[role="heading"]')
      clean_text(heading.text) if heading
    end

    def labeled_name(item)
      anchor = item.name == 'a' ? item : search_anchors(item).first
      label = anchor['aria-label'] || anchor['title']
      clean_text(label) if label
    end

    def caption_texts(item)
      item.css('div')
          .reject { |div| div.at_css('div') }
          .map { |div| clean_text(div.text) }
          .reject(&:empty?)
    end

    def clean_text(text)
      text.gsub(/\s+/, ' ').strip
    end

    def link_for(item)
      href = item.name == 'a' ? item['href'] : search_anchors(item).first['href']
      href.start_with?('/') ? "#{BASE_URL}#{href}" : href
    end

    # `src` is always a placeholder GIF; real thumbnails live in the inline
    # script map or in `data-src`.
    def image_for(image_node, inline_images)
      inline_images[image_node['id']] || image_node['data-src']
    end
  end
end
