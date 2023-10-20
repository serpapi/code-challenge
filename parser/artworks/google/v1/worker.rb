# frozen_string_literal: true

module Parser
  module Artworks
    module Google
      module V1
        class Worker < Parser::Artworks::Google::BaseWorker
          CAROUSEL_ITEM_TAG = '.klitem'
          CAROUSEL_ITEM_NAME_TAG = '.kltat'
          CAROUSEL_ITEM_YEAR_TAG = '.klmeta'

          private

          def link(item)
            item.attr(CAROUSEL_ITEM_HREF_ATTR)
          end
        end
      end
    end
  end
end
