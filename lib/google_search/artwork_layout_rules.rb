# frozen_string_literal: true

module GoogleSearch
  class ArtworkLayoutRules
    ARTWORKS_ROOT_SELECTOR = '[data-attrid="kc:/visual_art/visual_artist:works"]'
    CARD_LIST_CANDIDATE_SELECTOR = "*:has(> * > a > img)"
    CardParts = Data.define(:anchor, :image, :field_container)
    STRUCTURAL_RULE = {
      id: "structural_layout",
      label: "Validate already-located cards"
    }.freeze
    RULES = [ STRUCTURAL_RULE ].freeze

    def initialize(document)
      @document = document
    end

    def cards
      cards = artwork_card_list(artwork_root).element_children
      if cards.empty?
        raise ArtworkLayoutError, "The artwork section contains no artwork cards"
      end

      cards
    end

    def matches?(collection_cards, rule)
      return false unless rule == STRUCTURAL_RULE

      !collection_cards.empty? && collection_cards.all? { |card| valid_card?(card) }
    end

    def card_parts(card)
      anchor = direct_card_anchor(card)
      return unless anchor

      anchor_children = anchor.element_children.to_a
      return unless anchor_children.length == 2

      images, field_containers = anchor_children.partition { |child| child.name == "img" }
      return unless images.one? && field_containers.one?

      field_container = field_containers.first
      field_count = field_container.element_children.length
      return unless field_count.between?(1, 2)

      CardParts.new(anchor: anchor, image: images.first, field_container: field_container)
    end

    private
      def artwork_root
        artwork_root = @document.at_css(ARTWORKS_ROOT_SELECTOR)
        return artwork_root if artwork_root

        raise ArtworkSectionNotFound, "Could not find Google's artwork section"
      end

      def artwork_card_list(root)
        candidates = root.css(CARD_LIST_CANDIDATE_SELECTOR)
        if candidates.empty?
          raise ArtworkLayoutError, "The artwork section contains no artwork cards"
        end

        valid_card_lists = candidates.select do |node|
          valid_card_list?(node)
        end
        if valid_card_lists.length > 1
          raise ArtworkLayoutError, "Found more than one possible artwork card list"
        end

        card_list = valid_card_lists.first
        if card_list && (candidates.length == 1 || !nested_in_candidate?(card_list, candidates))
          return card_list
        end

        raise ArtworkLayoutError, "The artwork card list uses an unsupported HTML structure"
      end

      def nested_in_candidate?(card_list, candidates)
        card_list.ancestors.any? { |ancestor| candidates.include?(ancestor) }
      end

      def valid_card_list?(node)
        cards = node.element_children
        !cards.empty? && cards.all? { |card| valid_card?(card) }
      end

      def valid_card?(card)
        !card_parts(card).nil?
      end

      def direct_card_anchor(card)
        children = card.element_children
        return unless children.length == 1

        anchor = children.first
        anchor if anchor.name == "a"
      end
  end
end
