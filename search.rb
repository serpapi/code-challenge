Dir[File.join(__dir__, 'parsers', '*.rb')].each { |file| require file }
require 'nokogiri'
require 'pry'

class Search
  def initialize(q:, file_path:, version: :old)
    @html = File.open(file_path)
    @version = version
  end

  def html_to_hash
    data
  end

  def knowledge_graph
    @knowledge_graph ||= Parsers::KnowledgeGraph.new(parsed_html, version)
  end

  private

  attr_reader :html, :version

  def data
    @data ||=
      {
        knowledge_graph: knowledge_graph.data
      }
  end

  def parsed_html
    @parsed_html ||= Nokogiri::HTML(html)
  end
end
