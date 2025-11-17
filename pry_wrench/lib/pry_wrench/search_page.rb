require 'nokogiri'

module PryWrench

  class SearchPage
    attr_reader :scraped_items

    def initialize(raw_html)
      @doc = Nokogiri::HTML(raw_html)

      all_thumbs = @doc.xpath('//*[@id="kp-wp-tab-ArtistToArtworks"]/div[1]/div/div/div[2]/div/div/div/div[1]/div/a')

      @scraped_items = all_thumbs.map do |thumb|
        [
          thumb.children.last.children.first.text, # name
          thumb.children.last.children.last.text.split(" "), # extensions
          "https://google.com#{thumb.attr('href')}" # link
        ]
      end

    end

  end
end
