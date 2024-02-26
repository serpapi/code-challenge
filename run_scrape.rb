require './files/scraper_tool'

root_dir = File.expand_path('.')
painting_url = "#{root_dir}/files/van-gogh-paintings.html"
tool = ScraperTool.new(painting_url)
puts tool.scrape_carousel