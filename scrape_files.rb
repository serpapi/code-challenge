require_relative 'lib/google_search_page_crawler'

def file_path(name)
  File.join(File.dirname(__FILE__), "files", "#{name}")
end

def write_to_file(name, content)
  File.write(file_path(name), content)
end

crawler = GoogleSearchPageCrawler.new

file_name = ARGV.first || "van-gogh-paintings.html"
puts "Scraping #{file_name}"

results = crawler.crawl(file_path(file_name))

puts results.to_json

write_to_file(file_name.to_s.gsub(".html", "-results.json"), results)
