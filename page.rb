#!/usr/bin/ruby

require "nokogiri"
require "json"

class Page
  def initialize(file)
    @artworks = []
    @parsed_page ||= File.open(file) { |f| Nokogiri::HTML(f) }
  end
    
  def parse()
    @parsed_page.css("g-scrolling-carousel a[aria-label]").each do |carousel|
      name = carousel["aria-label"]
      link = carousel["href"].start_with?("https://www.google.com") ? carousel["href"] : "https://www.google.com" + carousel["href"]
      extensionText = carousel.text
        .gsub("-\n", "-") # title in the card breaks at "-", eg, line1: Service-\n, line2: Orient...
        .gsub("\n", " ")
        .gsub(name, "")
      extensionText.strip!

      parsed = {
        name: name,
        link: link,
      }

      if(extensionText.length > 0)
        parsed[:extensions] = [ extensionText ]
      end

      img_node = carousel.css("img")[0]
      # TODO: not able to get img_node["data-lzy_"]
      parsed[:image] = img_node["src"]

      @artworks << parsed
    end   

    JSON.generate(@artworks)
  end  
end
