# frozen_string_literal: true

require "uri"

require_relative "artwork_layout_rules"
require_relative "inline_image_sources"

module GoogleSearch
  class ArtworkPage
    GOOGLE_ORIGIN = URI.parse("https://www.google.com/").freeze
    PLACEHOLDER_IMAGE = "data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="

    def initialize(document, layout_rules: ArtworkLayoutRules.new(document))
      @document = document
      @layout_rules = layout_rules
    end

    def call
      cards = @layout_rules.cards
      image_sources = recover_script_image_sources(cards)

      { "artworks" => build_artworks(cards, image_sources) }
    end

    def script_image_count(cards)
      cards.count { |card| script_image_id(card) }
    end

    def recover_script_image_sources(cards)
      InlineImageSources.new(@document, requested_image_ids: script_image_ids(cards))
    end

    def build_artworks(cards, image_sources)
      cards.each_with_index.map do |card, index|
        extract_artwork(card, index + 1, image_sources)
      end
    end

    private
      def script_image_ids(cards)
        cards.filter_map { |card| script_image_id(card) }.uniq
      end

      def script_image_id(card)
        image = @layout_rules.card_parts(card).image
        return if direct_image_source(image)

        nonblank_value(image["id"])
      end

      def extract_artwork(card, card_number, image_sources)
        card_parts = @layout_rules.card_parts(card)
        name, extensions = artwork_fields(card_parts, card_number)
        unless name
          raise MalformedCard, "Card #{card_number} is missing a name"
        end

        item = { "name" => name }
        item["extensions"] = extensions unless extensions.empty?

        item["link"] = normalized_link(card_parts.anchor, card_number)

        image = image_source(card_parts.image, image_sources)
        item["image"] = image if image

        item
      end

      def artwork_fields(card_parts, card_number)
        fields = card_parts.field_container.element_children

        name = nonblank_value(fields.first.text)
        return [ nil, [] ] unless name

        image_name = nonblank_value(card_parts.image["alt"])
        unless image_name
          raise MalformedCard, "Card #{card_number} has no image alt text to confirm its displayed name"
        end
        if name != image_name
          raise MalformedCard, "Card #{card_number}'s displayed name and image alt text differ"
        end

        extension = nonblank_value(fields.last.text) if fields.length == 2
        extensions = extension ? [ extension ] : []

        [ name, extensions ]
      end

      def normalized_link(anchor, card_number)
        href = nonblank_value(anchor["href"])
        unless href
          raise MalformedCard, "Card #{card_number} is missing a link"
        end

        parsed = URI.parse(href)
        if parsed.scheme && parsed.scheme != "https"
          raise InvalidLink, "Card #{card_number} link must use HTTPS, not #{parsed.scheme.inspect}"
        end

        resolved = GOOGLE_ORIGIN.merge(parsed)
        unless valid_google_link?(resolved)
          raise InvalidLink, "Card #{card_number} link must use https://www.google.com"
        end

        resolved.to_s
      rescue URI::InvalidURIError
        raise InvalidLink, "Card #{card_number} has an invalid link"
      end

      def valid_google_link?(uri)
        uri.scheme == "https" && uri.host == "www.google.com" && uri.port == 443 && uri.userinfo.nil?
      end

      def image_source(image, image_sources)
        direct_image_source(image) || script_image_source(image, image_sources)
      end

      def direct_image_source(image)
        usable_image_source(image["data-src"]) || usable_image_source(image["src"])
      end

      def script_image_source(image, image_sources)
        image_id = nonblank_value(image["id"])
        return unless image_id

        usable_image_source(image_sources[image_id])
      end

      def usable_image_source(value)
        source = nonblank_value(value)
        return if source == PLACEHOLDER_IMAGE

        source
      end

      def nonblank_value(value)
        stripped = value&.strip
        stripped unless stripped.nil? || stripped.empty?
      end
  end
end
