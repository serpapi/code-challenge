# frozen_string_literal: true

# Class that scrapes carousel that returns json
class ScraperTool
  def initialize(url)
    @url = url
  end

  attr_reader :url

  def scrape_carousel
    result_hash = {}
    result_hash.to_json
  end
end