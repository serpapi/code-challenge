require 'nokogiri'
require_relative 'information_card'
require 'json'
require 'watir'

class ScrapeContent
  ROOT_NODE = 'artworks'
  attr_accessor :document

  def initialize file_path: nil, carousel_element_selector: '.EDblX.DAVP1'
    begin
      @file_path = file_path
      @element_css_selector = carousel_element_selector
      @document = Nokogiri::HTML(open_file(file_path))
    rescue => exception
      pp 'Unable to open provided file'
      pp exception.message
    end
  end

  def call
    @scraped_data ||= parse_content
    export_json
  end

  def parse_content
    card_elements = @document.css(@element_css_selector).first.children.css('a')
    card_elements.map { |card_element| InformationCard.new(card_element).to_h }
  end

  def export_json
    output_file_path = @file_path.gsub('.html', '.json')
    File.open(output_file_path, 'w+') do |file|
      file.write(format_content)
    end
    output_file_path
  end

  def format_content
    JSON.pretty_generate("#{ROOT_NODE}": @scraped_data)
  end

  def open_file(file_path)
    browser = Watir::Browser.new
    file_path = File.expand_path(file_path)
    browser.goto("file:///#{file_path}")
    browser.html
  end
end
