# frozen_string_literal: true

require 'nokogiri'
require 'json'

class ExtractPaintings
  SUPPORTED_FORMATS = %i(array json knowledge_graph)

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
        image_id = sub.children[0].children[0].children[0].children[0].attribute('id').value rescue nil
        h['image'] = sub.children[0].children[0].children[0].children[0].attribute('src').value rescue nil
        if image_id && h['image']
          h['image'] = replace_image(image_id)
        end
        # Not valid childrens:
        ary << h if h['name'] != 'nope'
      end
      @original_html_text = nil
      ary
    end

    # The HTML file contains a script to replace images:
    def replace_image(image_id)
      @original_html_text ||= File.read(@html_file) #, encoding: 'UTF-8')
      regex = /\(function\(\){var s=\'([^']+)\';var ii=\[\'#{image_id}\'\];_setImagesSrc\(ii,s\);}/
      m = @original_html_text.match(regex)
      if m
        # Some escape characters cause encoding issues (base 64 padding, '='):
        m.captures[0].gsub(/((\\x3d)+)$/) do |t|
          # \x3d+ => x3d+
          a = t.split("\\")  # ["", "x3d", "x3d", ...]
          a.shift            # ["x3d", "x3d", ...]
          a.join
        end
      end
    end

    # -- Output formatters:

    def to_array(hash)
      hash['artworks']
    end

    def to_json(hash)
      hash.to_json
    end

    def to_knowledge_graph(paintings_hash)
      knowledge_graph = {
        'title' => 'Vincent van Gogh',
        'image' => 'https://upload.wikimedia.org/wikipedia/commons/4/4c/Vincent_van_Gogh_-_Self-Portrait_-_Google_Art_Project_%28454045%29.jpg',
        'description'=> 'Vincent Willem van Gogh was a Dutch Post-Impressionist painter who is among '\
                        'the most famous and influential figures in the history of Western art. In just '\
                        'over a decade he created about 2,100 artworks, including around 860 oil '\
                        'paintings, most of them in the last two years of his life.',
        'source' => {
          'name' => 'Wikipedia',
          'link' => 'https://en.wikipedia.org/wiki/Vincent_van_Gogh'
        },
        'born' => 'March 30, 1853, Zundert, Netherlands',
        'died' => 'July 29, 1890, Auvers-sur-Oise, France',
        'education' => 'Royal Academy of Fine Arts, Académie Royale des Beaux-Arts',
        'periods' => 'Realism, Post-Impressionism, Modern art, Impressionism, Japonism, Cloisonnism, '\
                     'Pointillism, Neo-impressionism',
        'movies' => 'Lust for Life',
        'siblings' => 'Theo van Gogh, Wil van Gogh, Cor van Gogh'
      }.merge(paintings_hash)
      { 'knowledge_graph' => knowledge_graph }
    end
  end
end
