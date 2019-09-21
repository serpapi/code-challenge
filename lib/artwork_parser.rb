# frozen_string_literal: true

class ArtworkParser
  DOMAIN = 'https://www.google.com'

  attr_reader :nokogiri_obj

  def initialize(nokogiri_obj)
    @nokogiri_obj = nokogiri_obj
  end

  def call
    {
      'name' => name,
      'link' => link,
      'extensions' => extensions,
      'image' => images
    }.compact
  end

  def link
    "#{domain}#{nokogiri_obj.attribute('href').text}"
  end

  def name
    nokogiri_obj.css('.kltat').text.strip
  end

  # added a note about image extraction to pull request https://github.com/serpapi/code-challenge/pull/11
  def images
    img = nokogiri_obj.css('img')
    img.attribute('data-src')&.text || img.attribute('data-key')&.text
  end

  def extensions
    year = nokogiri_obj.css('.klmeta').text
    return nil if year.empty?

    [year]
  end

  def domain
    DOMAIN
  end
end
