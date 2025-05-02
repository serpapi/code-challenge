require 'ferrum'
require 'json'

require_relative 'factories/gallery_parser_factory'

if __FILE__ == $0
  url = "file://#{File.expand_path(ARGV.first)}"

  browser = Ferrum::Browser.new(headless: true)
  page = browser.create_page
  page.go_to(url)

  parser = GalleryParserFactory.from_page(page)

  artworks = parser.parse(page)

  puts JSON.pretty_generate(artworks)
end