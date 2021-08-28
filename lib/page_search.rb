# frozen_string_literal: true

require 'nokogiri'

# Returns all nodes in a Nokogiri::XML::NodeSet format from a specific search.
class PageSearch
  def initialize(page, nodes)
    @page = page
    @nodes = nodes
  end

  def search
    Nokogiri::HTML(@page).css(@nodes)
  end
end
