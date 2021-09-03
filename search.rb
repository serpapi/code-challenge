Dir[File.join(__dir__, 'parsers', '*.rb')].each { |file| require file }
require 'nokogiri'
require 'pry'

class Search
  def initialize(q:, file_path:)
    @html = File.open(file_path)
  end

  def html_to_hash
    data
  end

  private

  attr_reader :html

  def data
    @data ||=
      {
        knowledge_graph: Parsers::KnowledgeGraph.new(parsed_html).data
      }
  end

  def parsed_html
    @parsed_html ||= Nokogiri::HTML(html)
  end
end
