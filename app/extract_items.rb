require 'nokogiri'
require 'json'
require_relative 'knowledge_item'

class ExtractItems
  def initialize(html_file)
    @html_file = html_file
    @document = Nokogiri::HTML(html_file)
    @output_data = []
  end

  def run
    html_elements = @document.css('.klitem')

    html_elements.each do |html_element|
      @output_data << KnowledgeItem.new(html_element).to_h
    end

    output_results_in_json_file
  end

  private


  def output_results_in_json_file
    file_path = @html_file.path
    file_path.gsub!('.html', '.json')

    File.open(file_path, 'w') do |f|
      f.write(JSON.pretty_generate(artworks: @output_data))
    end
  end
end