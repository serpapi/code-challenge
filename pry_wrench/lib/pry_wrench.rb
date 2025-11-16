require "pry_wrench/version"
require "pry_wrench/search_page"


module PryWrench

  def self.process_html(raw_html)
    search_page = SearchPage.new(raw_html)
    search_page.scraped_items
  end

end
