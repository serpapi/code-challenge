# frozen_string_literal: true

module Parser
  module Artworks
    module Google
      module V2
        class Worker < Parser::Artworks::Google::BaseWorker
          CAROUSEL_ITEM_TAG = '.iELo6'
          CAROUSEL_ITEM_NAME_TAG = '.pgNMRc'
          CAROUSEL_ITEM_YEAR_TAG = '.cxzHyb'

          private

          def link(item)
            item.at_css('a').attr(CAROUSEL_ITEM_HREF_ATTR)
          end
        end
      end
    end
  end
end
