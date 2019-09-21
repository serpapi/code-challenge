# frozen_string_literal: true
require 'nokogiri'
require 'byebug'

class ArtworksParser
  def extract_paitings(page)
    page.css('.klitem').map do |element|
      extract_paiting(element)
    end
  end

  def extract_paiting(element)
    {
      'name' => element.css('.kltat').text.strip,
      'extensions' => [
        element.css('.klmeta').text.to_i
      ],
      'link' => 'https://www.google.com' + element.attribute('href').text
    }
  end
end
