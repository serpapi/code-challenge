require 'nokogiri'
require 'open-uri'

# Parses Google Search results into readable JSON objects
class GoogleSearchParser
  SCROLLING_CAROUSEL_TAG = 'g-scrolling-carousel'.freeze
  CAROUSEL_CARD_TAG = 'a'.freeze

  attr_reader :document

  # Accepts a path to a HTML file of Google Search results
  def initialize(html_path)
    @document = Nokogiri::HTML(URI.open(html_path))
  end

  def carousel_json
    # A bit naive - The metadata of search results are sometimes displayed in different layouts
    # such as a grid view, and sometimes the first carousel is not the type of data we're looking for
    # such as when it's related searches, etc. Could be improved
    carousel = @document.at_css(SCROLLING_CAROUSEL_TAG)
    carousel_cards = carousel&.css(CAROUSEL_CARD_TAG)
    return [] if carousel.nil?

    carousel_cards.map { |card| carousel_card_to_json(card) }
  end

  # Accepts an <a> tagged card from the carousel of the Google Search result page
  def carousel_card_to_json(card)
    # Grabbing from aria label preferable to aggregating the spans that cross multiple lines
    name = card.attr('aria-label')

    relative_link = card.attr('href')
    absolute_link = relative_link && "https://www.google.com#{relative_link}"

    img_div = card.children[0]
    img = img_div.at_css('g-img img')
    # absent images are still available under 'data-src' but intentionally left out due to requiring extra requests
    img_src = img&.attr('src')


    info_div = card.children[1]
    extension_block  = info_div&.children[1]
    # can there possibly be more than one extension?
    # Seems to be only 0 or 1 but if more are possible would need to tweak this
    extension = extension_block&.text

    {
      'name' => name,
      'extensions' => [extension].compact,
      'link' =>  absolute_link,
      'image' => img_src,
    }
  end
end
