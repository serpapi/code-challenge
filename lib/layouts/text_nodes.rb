module Layouts
  # Shared XPath text-node extraction for layout adapters.
  module TextNodes
    private

    def text_nodes(node)
      node.xpath(".//text()[normalize-space()]").map { |t| t.text.strip }.reject(&:empty?)
    end
  end
end
