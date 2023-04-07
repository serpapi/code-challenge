class NodeParser
  attr_reader :node

  def initialize(node, base_url)
    @node = node
    @base_url = base_url
  end

  def parse_node
    result = {
      name: name,
      link: link,
      image: image
    }
    result.merge!({ extensions: extensions }) if extensions&.any?
    result
  end

  private

  def name
    node&.at_css('.kltat')&.text
  end

  def extensions
    node&.css('.ellip.klmeta')&.collect{|t| t.text}&.compact
  end

  def link
    @base_url + node&.at_css('a.klitem')&.[]('href')&.gsub('file://', '') if node
  end

  def image
    data = node&.at_css('img')&.[]('src')
    data == "" ? nil : data
  end
end
