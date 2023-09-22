
require 'nokogiri'


module Google
  class CarouselParser
    attr_accessor :doc, :date, :date_expr, :node_map, :node_items, :artworks, :error

    def initialize(file_path=nil)
      @doc = nil
      # Find and extract the carousel elements
      #carousel_elements = doc.css('div.g [role="heading"]')
      @node_items = {'Items' => 'g-scrolling-carousel a.klitem, g-scrolling-carousel a.klitem-tr'}
      @node_map = {
        'Name' => 'div.kltat',
        'Date' => 'div.ellip',
        'Image' => 'img',
      }

      artwork_collection = []
      # Initialize an array to store extracted data
      @artworks = { artworks: artwork_collection }
      # Initialize an array to store extracted data
      @date = []
      # create an expression to extract date
      @date_expr = /\((\d{4})\)/
      # Parse the HTML file using Nokogiri
      if file_path
        @doc = Nokogiri::HTML(File.open(file_path))
        parse
      else
        @error = "No File"
      end
    end

    def parse
      items = @doc.css(@node_items["Items"])
      # Use the hash map to find and print specific nodes
      if items
        items.each do |painting|
          item_hash = {}
          @node_map.each do |node_name, selector|
            node = painting.at_css(selector)
            item_hash[:link] = painting['href']
            if node
              case node_name
              when 'Name'
                # Extract the 'text' attribute of the 'name' element
                item_hash[:name] = node.text
              when "Image"
                # Extract the 'data-key', 'data-src' or 'src' attribute of the 'image' element
                item_hash[:image] = node['data-key']
                item_hash[:image] = node['data-src'] if item_hash[:image].nil?
                item_hash[:image] = node['src'] if item_hash[:image].nil?
              when "Date"
                # Extract the 'text' attribute of the 'date' element
                item_hash[:extensions] = [node.text]
              end
            else
              item_hash[:error] = "Node '#{node_name}' not found."
            end
          end
          @artworks[:artworks] << item_hash
        end
      end
    end
  end
end


#html_file_path = '../files/van-gogh-paintings.html'
#my_instance = Google::CarouselParser.new(html_file_path)
#puts my_instance.artworks[:artworks].inspect



