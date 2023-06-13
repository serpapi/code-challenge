require 'nokogiri'

class HtmlDocument
  def initialize(html_content)
    # Parse the HTML content using Nokogiri
    @parsed_content = Nokogiri::HTML(html_content)
  end

  def carousel
    # Return all 'a' elements inside the 'g-scrolling-carousel' element
    @parsed_content.css('g-scrolling-carousel a')
  end
end