require 'json'

require_relative './constants'
require_relative './scraper'
require_relative './util'

def main
  doc = Scraper.nokodoc_via_selenium(url: Constants::FILE_URL, 
                                     pause_for_web_inspector: false)
  items = Scraper.scrape(noko_html_doc: doc)

  json_data = JSON.pretty_generate(artworks: items)

  output_filename = './scrape_output.json'
  File.write(output_filename, json_data)
  puts "See #{output_filename} for results."
end

main
