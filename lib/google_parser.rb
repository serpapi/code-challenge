require 'ferrum'
require './lib/node_parser'

class GoogleParser
  attr_reader :browser
  BASE_URL = 'https://www.google.com'

  def initialize(file_path)
    @browser = Ferrum::Browser.new
    @browser.go_to(file_path)
  end

  def parse
    {
      artworks:
        all_nodes.collect do |node|
          NodeParser.new(node, BASE_URL).parse_node
        end
    }
  end

  private

  def all_nodes
    browser.css('div.MiPcId.klitem-tr.mlo-c')
  end
end
