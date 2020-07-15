# encoding: UTF-8

require 'pp'
require_relative 'lib/google_image_search'

class Serpapi < Thor
  desc "search_google_image SEARCH_KEYWORD", "A command to extract thumbnails data from Google search result page"
  def search_google_image(search_keyword)
    pp GoogleImageSearch.search(q: search_keyword)
  end
end