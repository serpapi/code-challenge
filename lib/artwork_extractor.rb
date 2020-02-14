require 'nokogiri'

class ArtworkExtractor

  attr_reader :document

  CARDS_CSS_SELECTOR = 'a.klitem'

  def initialize(file)
    @document = Nokogiri::HTML.parse(file)
  end

  def html
    @document.inner_html
  end

  def extract_names
    name_attribute = 'aria-label'
    cards.map {|item| item[name_attribute] }
  end

  private

  def cards
    @document.css(CARDS_CSS_SELECTOR)
  end

end