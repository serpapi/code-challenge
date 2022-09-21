require 'nokogiri'

class Parser
  def initialize(filename)
    @doc = File.open(filename) { |f| Nokogiri::HTML(f, nil, 'UTF-8') }
  end

  def parse
    array = []
    @doc.css('g-scrolling-carousel a').first.parent.parent.children.each_with_index do |item, i|
      hash = {}
      year_selector = item.css('div.ellip.klmeta, div.MVXjze.ellip.buTsJf')
      if year_selector.size > 0
        hash['extensions'] = [year_selector[0].text.strip]
      end
      link = item.css('a').first
      hash['name'] = link['aria-label'] || link['title']
      hash['link'] = "https://www.google.com#{link['href']}"
      item.css('img').each do |img|
        hash['image'] = nil
        hash['image'] = image_array[i][0].gsub('\\', '') if image_array[i] and i < 8 # expected results only have 8 thumbnail images
      end
      array << hash
    end
    { 'artworks' => array }
  end

  def image_array
    @images ||= @doc.content.scan(/var s='(\S+)';/)
  end
end
