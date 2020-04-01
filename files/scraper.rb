require 'json'
require 'nokogiri'

module Scraper
  # Parses Google appbar items from the given HTML file and returns the relevant keys in JSON.
  #
  # @param [String] file
  # @return [String]
  def parse_appbar_from(file: './files/van-gogh-paintings.html')
    html = Nokogiri::HTML(File.read(file))

    # van-gogh paintings.html is using an older version of Google's search page
    items = html.css('.klbar div.klitem-tr').empty? ? html.css('.klbar div.klitem') : html.css('.klbar div.klitem-tr')

    array =
      items.map do |node|
        {
          name: node.css('.kltat').text,
          extensions: node.css('.klmeta').text.empty? ? nil : [node.css('.klmeta').text],
          link: "https://www.google.com#{node.css('a').attribute('href')}",
          thumbnail: node.css('img').attribute('src')&.text
        }
      end

    array.to_json
  end

  module_function :parse_appbar_from
end
