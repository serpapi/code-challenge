# frozen_string_literal: true

require_relative 'parsers/google_artworks_parser'
require_relative '../browser_navigator'
require_relative '../cache_handler'
require 'open-uri'
require 'json'

class GoogleSearch

  BASE_URL = 'https://www.google.com/search?q='

  STATIC_SEARCHES = {
    # supplied as test example
    'van gogh' => 'https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html',
    # two more actual results, with a slightly new format
    'monet' => 'https://raw.githubusercontent.com/CodeWoken/test-test/main/google-search-monet.html',
    'caravaggio' => 'https://raw.githubusercontent.com/CodeWoken/test-test/main/google-search-caravaggio.html',
  }

  def initialize(q: nil, cache: true)
    @use_cache = cache
    read_content(q:)
  end

  def read_content(q: nil)
    cache = ::CacheHandler.new(key: q)
    @content = if @use_cache && cache.exists?
                 cache.read
               elsif STATIC_SEARCHES[q]
                 ::URI.open(STATIC_SEARCHES[q]).read
               else
                 ::BrowserNavigator.new(url: BASE_URL + q).get_content
               end
    cache.store(value: @content) if @use_cache
  end

  def get_artworks(formatted: false)
    json_result = GoogleArtworksParser.new(html: @content).get_result
    # adjust to the expected write format
    return "\"artworks\": #{JSON.pretty_generate(json_result)}" if formatted

    json_result
  end

  def get_html
    @content
  end
end
