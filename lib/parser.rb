require 'nokogiri'

class Parser
  def initialize(filename)
    @doc = File.open(filename) { |f| Nokogiri::HTML(f, nil, 'UTF-8') }
  end

  def parse
    array = []
    @doc.css('div#appbar g-scrolling-carousel div div').children.each do |item|
      hash = {}
      hash['name'] = item.css('div div')[1].content if item.css('div div')[1]
      hash['extensions'] = [item.css('div div')[2].content] if item.css('div div')[2]
      item.css('a').each do |i|
        hash['link'] = "https://www.google.com#{i['href']}"
      end
      next unless hash['link']
      item.css('img').each do |i|
        hash['image'] = nil
        key = i.attr('id').tr('kximg', '').to_i
        hash['image'] = image_array[key][0].gsub('\\', '') if image_array[key] and key < 8
      end
      array << hash
    end
    { 'artworks' => array }
  end

  def image_array
    @images ||= @doc.content.scan(/var s='(\S+)';/)
  end
end
