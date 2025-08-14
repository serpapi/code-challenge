require_relative 'lib/google_search_page_crawler'

def file_path(name)
  File.join(File.dirname(__FILE__), "files", "#{name}")
end

crawler = GoogleSearchPageCrawler.new

puts "Scraping van-gogh-paintings.html"

puts crawler.crawl(file_path("van-gogh-paintings.html"))