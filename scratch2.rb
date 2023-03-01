# frozen_string_literal: true

require 'ferrum'
require 'pry-byebug' # For now while doing doing dev
require 'nokogiri'
require 'json'

# Make sure chrome is in browser path, or pass it as ENV like:
# `BROWSER_PATH="/Applications/Google Chrome.app/Contents/MacOS" sudo pry`
# ^ there's sudo pry here because of permissions stuff. I'd dig into this when there's more time to make it easier

def parse_a(a_element)
  # Nokogiri::HTML adds extra tags (i.e. <body>)
  a_attributes = a_element.attributes.map { |k, v| [k, v&.text] }.to_h

  img_element = a_element.at('img')
  img_attributes = img_element.attributes.map { |k, v| [k, v&.text] }.to_h

  {
    "a" => a_attributes,
    "img" => img_attributes
  }
end

def extract_result_data(result)
  name = result['a']['aria-label']

  title = result['a']['title']

  puts [name, title].join(' - ')
  additional_text = title.gsub(name, '').strip
  additional_text.tr!('()', '')

  extensions = [additional_text]

  google_base_url = 'https://www.google.com'
  url = result['a']['href']
  link = "#{google_base_url}#{url}"
  image = result['img']['src']

  {
    "name" => name,
    "extensions" => extensions,
    "link" => link,
    "image" => image
  }
rescue NoMethodError => e

end

FILE_PATH = File.expand_path('files/van-gogh-paintings.html', File.dirname(__FILE__))
FILE_URL = "file:///#{FILE_PATH}"

NODES_XPATH = '//g-scrolling-carousel/div/div/div' # Gets the carousel items

# Ferrum options
options = {
  headless: false
}

browser = Ferrum::Browser.new(options)
browser.go_to(FILE_URL)

html = Nokogiri::HTML(browser.body)

collected_results = []

carousel_items = html.search("g-scrolling-carousel/div a")

carousel_items.each do |item|
  result = parse_a(item)
  data = extract_result_data(result)

  collected_results << data
end

generated_result = { 'artworks' => collected_results }

File.open('generated-result.json', 'w') do |file|
  file.puts JSON.pretty_generate(generated_result)
end

browser.reset
browser.quit