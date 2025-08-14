require 'nokogiri'

class GoogleSearchPageCrawler
  class Parser
    def initialize(html)
      @doc = Nokogiri::HTML(file_content)
    end

    def parse
      {
        "Artworks": [

        ]
      }
    end
  end
end
