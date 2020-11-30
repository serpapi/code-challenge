# frozen_string_literal: true

module Google
  # Logic for parsing single carousel node
  class CarouselNode
    # TODO: Should live in main Google class when it will be
    HOST = 'https://google.com'

    # Instance of Nokogiri::XML::Element
    def initialize(node)
      @node = node
    end

    # TODO: Use active_support#blank?
    def as_json
      {
        name: name,
        extensions: extensions,
        link: link,
        image: image
      }.reject { |_, v| v.nil? || v.empty? }
    end

    # I suppose we can assume that title will always present
    def name
      node['aria-label']
    end

    def extensions
      [year].compact
    end

    def year
      node.css('.klmeta').first&.text
    end

    def link
      File.join(HOST, node['href'])
    end

    # I suppose we can assume that image will always present
    def image
      node.css('g-img > img').first['src']
    end

    private

    attr_reader :node
  end
end
