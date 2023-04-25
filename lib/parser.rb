require 'nokogiri'
require 'open-uri'
require 'awesome_print'

class Parser

  def initialize(painting_wrapper)
    @painting_wrapper = painting_wrapper
    @title = @painting_wrapper&.attr('title')
  end

  def painting_exists?
    @title && name && image
  end

  def name
    @painting_wrapper&.attr('aria-label') || @title
  end

  def image
    @painting_wrapper&.css('img')&.first&.attr('src')
  end

  def link
    url = @painting_wrapper&.attr('href')
    "https://google.com#{url}" if url
  end

  def extensions
    year ? [year] : nil
  end

  private

  def year
    year = @title[/\d{4}/] if @title
    year =  @painting_wrapper&.children[1]&.text[/\d{4}/] if year.nil? && @painting_wrapper&.children
    year
  end
end
