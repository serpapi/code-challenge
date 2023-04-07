class NodeParser
  attr_reader :node

  def initialize(node, base_url)
    @node = node
    @base_url = base_url
  end

  def parse_node
    {
      name: name,
      extensions: extensions,
      link: link,
      image: image
    }
  end

  private

  def name
    node.at_css('.kltat').text
  end

  def extensions
    node.css('.ellip.klmeta')&.collect{|t| t.text}&.compact
  end

  def link
    @base_url + node.at_css('a.klitem')['href'].gsub('file://', '')
  end

  def image
    node.at_css('img')['src']
  end
end
