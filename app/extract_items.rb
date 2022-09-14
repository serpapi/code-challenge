require 'nokogiri'
require 'json'
require 'watir'
require_relative 'knowledge_item'

class ExtractItems
  attr_reader :document

  def initialize(html_file)
    @html_file = html_file
    @document = build_html_document
    @output_data = []
  end

  def run
    html_elements = document.css('.klitem')

    html_elements.each do |html_element|
      @output_data << KnowledgeItem.new(html_element).to_h
    end

    output_results_in_json_file
  end

  private

  def build_html_document
    Nokogiri::HTML(render_local_html_file)
  end

  # Render local html file in order to process javascript dom changes
  def render_local_html_file
    browser = Watir::Browser.new
    html_file_path = File.expand_path(@html_file.path)
    browser.goto("file:///#{html_file_path}")
    browser.html
  end

  def output_results_in_json_file
    file_path = @html_file.path
    file_path.gsub!('.html', '.json')

    File.open(file_path, 'w') do |f|
      f.write(JSON.pretty_generate(artworks: @output_data))
    end
  end
end