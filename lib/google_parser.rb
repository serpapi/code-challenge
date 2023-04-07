require 'ferrum'
require './lib/node_parser'

class GoogleParser
  attr_reader :browser

  def initialize(file_path)
    @browser = Ferrum::Browser.new
    @browser.go_to(file_path)
    @base_url = 'https://www.google.com'
  end

  def parse
    all_nodes.collect do |node|
      NodeParser.new(node, @base_url).parse_node
    end
  end

  private

  def all_nodes
    browser.css('div.MiPcId.klitem-tr.mlo-c')
  end
end
