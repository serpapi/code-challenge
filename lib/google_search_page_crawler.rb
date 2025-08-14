require_relative 'google_search_page_crawler/parser'

class GoogleSearchPageCrawler
  attr_reader :agent

  def crawl(file_path)
    html = open(file_path).read
    parser = GoogleSearchPageCrawler::Parser.new(html)
    parser.parse
  end
end