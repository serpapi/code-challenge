# frozen_string_literal: true

require 'nokogiri'
require 'ferrum'
require 'open-uri'

# Class that scrapes carousel that returns json
class ScraperTool
  def initialize(url)
    @url = url
  end

  attr_reader :url

  BASE_URL = 'https://www.google.com'

  def scrape_carousel
    first_carousel = get_carousel
    result_key = keyword(first_carousel)

    result_hash = {}
    result_hash[result_key] = cards_data(first_carousel)
    result_hash.to_json
  end

  private

  def get_carousel
    # Ferrum runs JavaScript to get transformed image data
    browser = Ferrum::Browser.new
    browser.go_to("file://#{url}")
    html = browser.body
    doc = Nokogiri::HTML5(html)
    doc.at('g-scrolling-carousel')
  end

  def keyword(carousel)
    carousel_ancestor = find_carousel_ancestor(carousel)
    carousel_heading = carousel_ancestor.at('[role="heading"]')
    texts = carousel_heading.xpath('.//text()')

    texts.last.text.downcase
  end

  def find_carousel_ancestor(carousel)
    current_node = carousel
    current_node = current_node.parent until current_node.at('[role="heading"]')
    current_node
  end

  def cards_data(carousel)
    cards = carousel.xpath('.//a[@href]')

    cards.map do |card|
      card_data(card)
    end
  end

  def card_data(card)
    text_values = name_and_extensions(card)
    extensions = text_values.last

    result = {}
    result['name'] = text_values.first
    result['extensions'] = extensions if extensions.any?
    result['link'] = BASE_URL + card['href']
    result['image'] = image(card)

    result
  end

  def name_and_extensions(card)
    values = card.xpath('.//text()').map(&:text)

    name = values.shift
    # handles case where word is split between elements
    name += values.shift while name.end_with?(' ')
    [name, values]
  end

  def image(card)
    image_el = card.at('img')
    image_el['src']
  end
end
