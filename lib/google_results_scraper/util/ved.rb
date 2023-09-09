module GoogleResultsScraper
  module Util
    module Ved
      module_function

      def find_element_with_type(node, type)
        elements_with_type(node, type).first
      end

      def elements_with_type(node, type)
        node.css('[data-ved]').to_a.filter do |node|
          ved = VedDecoder.decode(node['data-ved'])
          ved.type == type
        end
      end
    end
  end
end
