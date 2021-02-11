# frozen_string_literal: true

# https://youtu.be/HbvYeLxMKN8
require 'English'
require_relative '../lib/utils/tapp_amazing_print.rb'

module SERP
  GOOGLE_BASE_URL = 'https://www.google.com'

  GOOGLE_ART_CAROUSEL_STENCIL = {
    artworks: {
      selector: '[css] g-scrolling-carousel .klitem-tr',
      children: {
        name: {
          selector: '[css] .kltat',
          callback: lambda { |name|
            # Cleanup sample (actually #text method with extra spaces reduction could've been used)
            Sanitize.clean(name).strip.gsub(/\n/, '').gsub(/\s{2,}/, '')
          }
        },
        extensions: {
          selector: '[css] .klmeta',
          text: true
        },
        link: {
          selector: '[css] .klitem',
          callback: lambda { |item|
            "#{GOOGLE_BASE_URL}#{item['href']}"
          }
        },
        image_id: {
          selector: '[css] g-img img',
          attr: :id
        }
      }
    },
    content_script: {
      # IDEA: Consider usgin https://github.com/rubyjs/therubyracer
      #   with our own replacement of _setImagesSrc function to collect
      #   id => base64 pairs on JS execution
      selector: '[css] div#cnt > script',
      callback: lambda { |script|
        # to limit the sheer volume of scanned source
        if script.content =~ /\Afunction _setImagesSrc/
          matches = {}

          script.content.scan(/(?<img_id>kximg\d+).*?(?<base64>data\:.*?)(?>\')/) do
            # create image Hash using named captures
            image = Hash[%i[img_id base64].zip($LAST_MATCH_INFO.captures)]

            # set img_id => base64 with extra unescaping
            matches[image[:img_id]] = image[:base64].gsub('\\', '')
          end

          matches
        end
      }
    }
  }.freeze

  GOOGLE_ART_CAROUSEL_DATA_BUILDER = lambda { |data|
    top_key = GOOGLE_ART_CAROUSEL_STENCIL.keys.first
    result = { top_key => [] }

    data[top_key].map do |item|
      result[top_key] << HashRemapper.remap(
        item,
        name: :name,
        extensions: ->(value, _) { [:extensions, value && !value.empty? ? Array.wrap(value) : nil] },
        link: :link,
        image_id: ->(image_id, _) { [:image, data[:content_script]&.first&.fetch(image_id, nil)] }
      )
    end

    result
  }
end
