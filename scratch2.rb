# frozen_string_literal: true

require 'ferrum'
require 'pry-byebug' # For now while doing doing dev
require 'pry-rescue'
require 'nokogiri'

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

def parse_raw_html(html)
  # Nokogiri::HTML adds extra tags (i.e. <body>)
  node = Nokogiri::XML(html)
  a_element = node.at('a')
  a_attributes = a_element.attributes.map { |k, v| [k, v&.text] }.to_h

  img_element = node.at('img')
  img_attributes = img_element.attributes.map { |k, v| [k, v&.text] }.to_h

  {
    "a" => a_attributes,
    "img" => img_attributes
  }
end
# => {"a"=>
#   {"class"=>"klitem",
#    "aria-label"=>"The Starry Night",
#    "aria-posinset"=>"1",
#    "aria-setsize"=>"51",
#    "data-sp"=>"0,17,26",
#    "href"=>
#     "/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw",
#    "style"=>"height:193px;width:120px",
#    "title"=>"The Starry Night (1889)",
#    "role"=>"button",
#    "data-hveid"=>"47",
#    "data-ved"=>"0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw"},
#  "img"=>
#   {"data-key"=>
#     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq3gOqqnprlNb3SdEgrKAR_0sWrsu0kO0aNnwE3yRwmA_cf-PvBvdz4eInim3FDmRn7E0",
#    "id"=>"kximg0",
#    "src"=>
#     "data:image/jpeg;base64,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",
#    "data-deferred"=>"1",
#    "class"=>"rISBZc M4dUYb",
#    "height"=>"120",
#    "width"=>"120",
#    "alt"=>"",
#    "data-atf"=>"1"}}

def extract_result_data(result)
  # "artworks": [
  #   {
  #     "name": "The Starry Night",
  #     "extensions": [
  #       "1889"
  #     ],
  #     "link": "https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw",
  #     "image": "data:image/jpeg;base64,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"
  #   }
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

# carousel_items = browser.xpath(NODES_XPATH)
carousel_items = html.search("g-scrolling-carousel/div a")

carousel_items.each do |item|
  # raw_html = item.evaluate('this.outerHTML')
  result = parse_a(item)
  data = extract_result_data(result)

  collected_results << data
end

generated_result = { 'artworks' => collected_results }

File.open('generated-result.json', 'wb') do |file|
  file.puts generated_result.to_json
end

browser.reset
browser.quit