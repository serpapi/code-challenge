# frozen_string_literal: true

require 'nokogiri'
require 'json'

class ExtractPaintings
  SUPPORTED_FORMATS = %i(array json)

  class << self
    def parse_html(html_file, format: :json)
      @html_file = html_file
      raise 'File does not exist!' unless File.file?(html_file)
      raise 'Unsupported output format!' unless SUPPORTED_FORMATS.include?(format)
      hash = { 'artworks' => parse_file_to_array }
      send "to_#{format}", hash
    end

    private

    # -- Data parsing:

    def parse_file_to_array
      doc = File.open(@html_file) {|f| Nokogiri::HTML(f, nil, 'UTF-8')}
      # CSS class of the div enclosing the carousel images:
      nodes = doc.css('div.EDblX').children
      # Another possibility, but I noticed that in more recent Google pages this element is not present:
      # nodes = doc.css('g-scrolling-carousel').children[0].children[0].children
      ary = []
      nodes.each do |c|
        h = {}
        sub = c.children[0]
        h['name'] = sub.children[1].children[0].text rescue 'nope'
        year = sub.children[1].children[1].children[0].text rescue nil
        h['extensions'] = [ year ] if year
        h['link'] = 'https://www.google.com' + sub.attribute('href').value rescue nil
        # Images are only available for the visible part of the Carousel (we'll return nil in other cases):
        h['image'] = sub.children[0].children[0].children[0].children[0].attribute('src').value rescue nil
        # Not valid childrens:
        ary << h if h['name'] != 'nope'
      end
      ary
    end

    # -- Output formatters:

    def to_array(hash)
      hash['artworks']
    end

    def to_json(hash)
      hash.to_json
    end
  end
end
