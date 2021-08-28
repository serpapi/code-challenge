require 'nokogiri'

class PageSearch
  def initialize(page, nodes)
    @page = page
    @nodes = nodes
  end

  def search
    Nokogiri::HTML(@page).css(@nodes)
  end
end
