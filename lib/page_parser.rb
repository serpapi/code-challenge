# frozen_string_literal: true

require 'ferrum'
require 'json'

require_relative 'factories/parser_factory'

if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    puts "Usage: ruby #{$PROGRAM_NAME} <html_file>"
    puts "Example: ruby #{$PROGRAM_NAME} spec/fixtures/pages/van-gogh-paintings.html"
    exit 1
  end

  # Separation of concerns: loading the page is a separate concern from parsing the page
  # html can be supplied from elsewhere, e.g. a browser automation library
  browser = Ferrum::Browser.new(headless: true)
  page = browser.create_page
  page.go_to("file://#{File.expand_path(ARGV.first)}")

  # Separation of concerns: parsing the page is a separate concern from loading the page
  # Can be done elsewhere, e.g. in a browser automation library
  parser = ParserFactory.from_page(page)

  # Separation of concerns: formatting the output is a separate concern from parsing the page
  puts JSON.pretty_generate(parser.as_json)
end
