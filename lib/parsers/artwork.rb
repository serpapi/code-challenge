module Parsers
  class Artwork
    def initialize(file:)
      @file = file
    end

    def parse
      document = Nokogiri::HTML(file)
      document.xpath('//a[@class="klitem"]').map do |node|
        {
          name: node['aria-label'],
          extensions: [year_created(node)],
          link: painting_link(node)
        }.merge(image_attribute(node))
      end
    end

    private

    attr_reader :file

    def year_created(node)
      node.xpath('.//div[@class="ellip klmeta"]').first&.content
    end

    def painting_link(node)
      "https://google.com#{node['href']}"
    end

    def image_attribute(node)
      image_data = node.xpath('.//img[starts-with(@id, "kximg")]').first['src']
      image_data ? { image: image_data } : {}
    end
  end
end
