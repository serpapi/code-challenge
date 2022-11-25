# frozen_string_literal: true

require_relative 'config/capybara'

class GoogleCarouselImageParser
  # TODO: make configurable for user
  GOOGLE_URL = 'https://www.google.com'
  EXTENSIONS_SEPARATOR = ','
  EMPTY_STRING = ''

  module AttributeName
    ARIA_LABEL = 'aria-label'
    HREF = 'href'
    SOURCE = 'src'
  end

  module CSSSelector
    ANCHOR = 'a'
    CAROUSEL = 'g-scrolling-carousel'
    IMAGE = 'img'
  end

  module ResultKey
    NAME = 'name'
    EXTENSIONS = 'extensions'
    IMAGE = 'image'
    LINK = 'link'
  end

  def initialize(absolute_file_path:)
    raise(ArgumentError, "File does not exist: #{absolute_file_path}") unless File.exist?(absolute_file_path)
    @uri = "file://#{absolute_file_path}"
  end

  def parse
    carousel = fetch_carousel
    anchors = carousel.css(CSSSelector::ANCHOR)
    # TODO: check if JSON or Hash needs to be returned with an "artworks" node or similar
    anchors.map { |anchor| make_result(anchor) }
  end

  private

  def fetch_carousel
    html = fetch_html
    carousel = html.at_css(CSSSelector::CAROUSEL)
    raise(ArgumentError, 'HTML file does not contain a carousel element') if carousel.nil?
    carousel
  end

  def fetch_html
    browser = Capybara::Session.new(:selenium_chrome_headless)
    browser.visit(@uri)
    Capybara::HTML(browser.html)
  ensure
    browser.quit
  end

  def make_result(anchor)
    result = {}

    anchor_attributes = anchor.attributes
    name = anchor_attributes[AttributeName::ARIA_LABEL].value
    result[ResultKey::NAME] = name

    extensions = anchor.text.sub(name, EMPTY_STRING).split(EXTENSIONS_SEPARATOR).map(&:strip)
    result[ResultKey::EXTENSIONS] = extensions unless extensions.empty?

    image = anchor.at_css(CSSSelector::IMAGE)
    result[ResultKey::IMAGE] = image ? image.attributes[AttributeName::SOURCE]&.value : nil

    result[ResultKey::LINK] = File.join(GOOGLE_URL, anchor_attributes[AttributeName::HREF].value) # TODO: validations

    result
  end


end
