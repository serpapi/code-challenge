# frozen_string_literal: true

require 'ferrum'
require 'nokogiri'
require 'json'

# Make sure chrome is in browser path, or pass it as ENV like:
# `BROWSER_PATH="/Applications/Google Chrome.app/Contents/MacOS" sudo pry`
# ^ there's sudo pry here because of permissions stuff. I'd dig into this when there's more time to make it easier

class Runner
  # Ferrum options
  BROWSER_OPTIONS = {
    headless: false
  }.freeze

  def initialize(page_url, output_path = nil)
    @page_url = page_url
    @output_path = output_path
    @browser = Ferrum::Browser.new(BROWSER_OPTIONS)
  end

  def run
    @browser.go_to(@page_url)
    @html = Nokogiri::HTML(@browser.body)

    results = CarouselParser::Parser.new(@html).parse
    generated_result = { 'artworks' => results }

    json = JSON.pretty_generate(generated_result)

    if @output_path
      File.open(@output_path, 'w') do |file|
        file.puts json
      end
    end

    json
  ensure
    @browser.reset
    @browser.quit
  end
end
