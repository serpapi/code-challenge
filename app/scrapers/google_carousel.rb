# frozen_string_literal: true

module Scrapers
  # Parent class for versioned scrapers
  class GoogleCarousel
    def initialize(raw:, parsed:)
      @raw = raw
      @parsed = parsed
      @items = []
    end

    def call
      carousel_elements.each do |element|
        reset(element)
        add_entry_to_items
      end

      { heading.to_sym => items }
    end

    private

    attr_reader :raw, :parsed
    attr_accessor :items, :current_element
    attr_writer :link_element

    def add_entry_to_items
      items << {}.tap do |entry|
        entry[:name] = name
        entry[:extensions] = [year] unless year.nil?
        entry[:link] = link
        entry[:image] = image
      end
    end

    def reset(element)
      self.current_element = element
      self.link_element = nil
    end

    def carousel_elements
      all_boxes_selector = single_box_class.split(' ').map { |c| c.prepend('.') }.take(2).join('')
      parsed.css(all_boxes_selector)
    end

    def base_url
      raw.scan(%r{https://www\.google\.[a-z]+}).first
    end

    def link
      "#{base_url}#{link_element['href']}"
    end

    def name
      link_element['aria-label']
    end

    def year
      year_match = link_element['title'].match(/\((\d{4})\)/)
      return year_match[1] if year_match

      year_match = link_element.css('div').last&.inner_html
      year_match if year_match && year_match.to_i.to_s.size == year_match.size
    end

    def image
      image_element = link_element.css('img').first
      return unless image_element

      img_end_index = image_end_index(image_element)
      return unless img_end_index

      image_base64(img_end_index)
    end

    def image_end_index(image_element)
      img_id = image_element['id']
      code_after_image = "';var ii=['#{img_id}'];_setImagesSrc(ii,s)"
      raw.index(code_after_image)
    end

    def image_base64(img_end_index)
      left_cut = raw.slice(0..img_end_index - 1)
      code_before_img_start = "function(){var s='"
      img_start_index = left_cut.rindex(code_before_img_start) + code_before_img_start.size
      left_cut.slice(img_start_index..img_end_index).tr('\\', '')
    end
  end
end
