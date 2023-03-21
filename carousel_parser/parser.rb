# frozen_string_literal: true

module CarouselParser
  class Parser
    NODES_XPATH = '//g-scrolling-carousel//a' # Gets the carousel items
    GOOGLE_ABSOLUTE_URL = 'https://www.google.com'
    GOOGLE_DOMAIN = 'google.com'

    # Expects `html` to be a Nokogiri::HTML object
    def initialize(html)
      @html = html
      @collected_results = []
    end

    def parse
      carousel = @html.at_xpath('//g-scrolling-carousel')

      xpath = ".//a[starts-with(@href, '/search?')]"
      candidates = carousel.search(xpath)

      # Filter those without images
      candidates = candidates.select { |a_element| a_element.search('img').count == 1 }

      # Filter divs, select only those with a child div that contains a span OR contains a div that contains 2 children divs
      candidates = candidates.select do |a_element|
        divs = a_element.search('div')

        divs.any? do |div|
          div_children_count = div.children.select { |child| child.name == 'div' }.count
          child_span_count = div.children.select { |child| child.name == 'span' }.count
          div_children_count == 2 || child_span_count == 1
        end
      end

      candidates.each do |candidate|
        data = extract_raw_data(candidate)

        artwork = extract_artwork_struct(data)

        @collected_results << artwork.to_h
      end

      binding.pry

      @collected_results
    end

    private

    def extract_artwork_struct(raw_data)
      name = raw_data['div_data']['line_1']
      extensions = [ raw_data['div_data']['line_2'] ]
      extensions.map!(&:strip)

      link = raw_data['a_data']['href']
      if !link.include?(GOOGLE_DOMAIN)
        link = "#{GOOGLE_ABSOLUTE_URL}#{link}"
      end

      image = raw_data['img_data']['src']

      ArtworkStruct.new(
        name: name,
        extensions: extensions,
        link: link,
        image: image
      )
    end

    def extract_raw_data(candidate)
      data = {}

      img = candidate.at('img')

      div_parent_candidates = candidate.search('div').select do |div|
        div_children_count = div.children.select { |child| child.name == 'div' }.count
        child_span_count = div.children.select { |child| child.name == 'span' }.count
        div_children_count == 2 || child_span_count == 1
      end

      # Hacky solution but we can know for our test files that this case does not happen
      if img.nil? || div_parent_candidates.empty?
        binding.pry
      end

      data['a_data'] = extract_from_a(candidate)
      data['img_data'] = extract_from_image(img)
      data['div_data'] = extract_from_parent_div(div_parent_candidates[0])

      data
    end

    def extract_from_image(img)
      # Expects the img nested in the carousel item
      image_data = img.attributes.map { |k, v| [k, v&.text] }.to_h

      image_data
    end

    def extract_from_a(a)
      # Expects the a from the carousel item
      a_data = a.attributes.map { |k, v| [k, v&.text] }.to_h

      a_data
    end

    def extract_from_parent_div(div)
      # Expects the div with exactly 2 children div
      div_data = {}

      line_1, line_2 = div.children.map(&:inner_text)
      div_data['line_1'] = line_1
      div_data['line_2'] = line_2

      div_data
    end

    def parse_a(a_element)
      a_attributes = a_element.attributes.map { |k, v| [k, v&.text] }.to_h

      img_element = a_element.at('img')
      img_attributes = img_element.attributes.map { |k, v| [k, v&.text] }.to_h

      {
        "a" => a_attributes,
        "img" => img_attributes
      }
    end
  end
end

