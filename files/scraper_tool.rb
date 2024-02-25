# frozen_string_literal: true

# Class that scrapes carousel that returns json
class ScraperTool
  def initialize(url)
    @url = url
  end

  attr_reader :url
end
