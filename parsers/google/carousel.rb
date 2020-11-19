# frozen_string_literal: true

require 'watir'
require 'webdrivers'
require 'memoist'
require_relative './carousel_node'

module Google
  # Parsing Carousel
  class Carousel
    extend Memoist

    BROWSER_ARGS = {
      headless: true,
      timeout: 120,
      url: "http://#{ENV.fetch('HEADLESS_TESTING_ADDRESS')}/wd/hub"
    }.freeze

    def initialize(path:)
      @path = path
    end

    # TODO: Pagination support?
    # NOTE: 'button' old version, 'listitem' new version
    def as_json
      page.css('g-scrolling-carousel').first
          .css("a[role='button']", "a[role='listitem']")
          .map(&Google::CarouselNode.method(:new))
          .map(&:as_json)
    end

    private

    attr_reader :path

    memoize def page
      browser.goto(path)

      Nokogiri::HTML(browser.html, nil, Encoding::UTF_8.to_s).tap { |_|
        browser.close
      }
    end

    memoize def browser
      Watir::Browser.new(:chrome, BROWSER_ARGS)
    end
  end
end


require './parsers/google/carousel'
Google::Carousel.new(path: 'file:///tmp/files/pink-floyd-albums.htm').as_json
