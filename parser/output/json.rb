# frozen_string_literal: true

module Parser
  module Output
    class Json < Parser::Output::Base
      def render(raw_data)
        ::JSON.generate(
          { 'artworks' => raw_data.map { |item| item_json(item) } }
        )
      end

      private

      def item_json(item)
        {
          'name' => item.name,
          'extensions' => item.extensions,
          'link' => item.link,
          'image' => item.image
        }
      end
    end
  end
end
