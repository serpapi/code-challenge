# frozen_string_literal: true
# https://youtu.be/HbvYeLxMKN8
require 'English'

module SERP
  GOOGLE_BASE_URL = 'https://www.google.com'

  GOOGLE_CHARACTERS_CAROUSEL_STENCIL = {
    characters: {
      selector: '[css] g-scrolling-carousel .klitem-tr',
      children: {
        name: {
          selector: '[css] div',
          callback: lambda { |name|
            name.parent['data-entityname']
          }
        },
        extensions: {
          selector: '[css] div',
          callback: lambda { |ext|
            # in this case it's easier to extract it just from
            # the parenthesis in the titile
            ext.parent['title']&.match(/\((.*)\)/)&.captures&.fetch(0, nil)
          }
        },
        link: {
          selector: '[css] div',
          callback: lambda { |link|
            link.parent['href']
          }
        },
        image: {
          # TODO: Resolve an issue with the local "harry-potter-characters_files/images_003.jpg" image paths
          # TODO: Resolve an issue with "data:image/gif;base64,R0l...AOw==" 1x1 gif images
          selector: '[css] g-img img',
          callback: lambda { |img|
            img['src']
          }
        }
      }
    }
  }.freeze

  GOOGLE_CHARACTERS_CAROUSEL_DATA_BUILDER = lambda { |data|
    top_key = GOOGLE_CHARACTERS_CAROUSEL_STENCIL.keys.first
    result = { top_key => [] }

    data[top_key].map do |item|
      result[top_key] << HashRemapper.remap(
        item,
        name: ->(value, _) { [:name, value&.first] },
        extensions: ->(value, _) { [:extensions, Array.wrap(value)] },
        link: ->(value, _) { [:link, value&.first] },
        image: :image
      )
    end

    result
  }
end
