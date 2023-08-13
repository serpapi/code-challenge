module Scrapers
  class GoogleCarousel20190319
    BASE_URL = 'https://www.google.com'

    def initialize(raw:, parsed:)
      @raw = raw
      @parsed = parsed
      @items = []
    end

    def call
      carousel_elements.each do |element|
        reset(element)

        self.items << {}.tap do |entry|
          entry[:name] = name
          entry[:extensions] = [year] unless year.nil?
          entry[:link] = link
          entry[:image] = image
        end
      end

      { heading.to_sym => items }
    end

    private

    attr_reader :raw, :parsed
    attr_accessor :items, :current_element
    attr_writer :link_element

    def reset(element)
      self.current_element = element
      self.link_element = nil
    end

    def carousel_elements
      single_box_class = parsed.css('g-scrolling-carousel a').first.parent['class']
      all_boxes_selector = single_box_class.split(' ').map { |c| c.prepend('.') }.take(3).join('')
      parsed.css(all_boxes_selector)
    end

    def heading
      parsed.css('#extabar span span')[2].css('span')[1].inner_html.downcase
    end

    def link_element
      @link_element ||= current_element.css('a').first
    end

    def link
      "#{BASE_URL}#{link_element['href']}"
    end

    def name
      link_element['aria-label']
    end

    def year
      year_match = link_element.css('div').last.inner_html
      year_match if year_match.to_i.to_s.size == year_match.size
    end

    def image
      img_base = nil
      img_id = link_element.css('img').first['id']
      code_after_image = "';var ii=['#{img_id}'];_setImagesSrc(ii,s)"
      img_end_index = raw.index(code_after_image)

      if img_end_index
        left_cut = raw.slice(0..img_end_index - 1)
        code_before_img_start = "function(){var s='"
        img_start_index = left_cut.rindex(code_before_img_start) + code_before_img_start.size
        img_base = left_cut.slice(img_start_index..img_end_index)
        img_base.tr!('\\', '')
      end

      img_base
    end
  end
end
