# frozen_string_literal: true

require 'json'
require 'selenium-webdriver'

class Browser
  def self.open(page)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    driver = Selenium::WebDriver.for :chrome, options: options
    driver.navigate.to(String(page))
    yield driver
  ensure
    driver&.quit
  end
end

class FileURI
  def initialize(path)
    @path = path
  end

  def to_s
    "file://#{File.expand_path(@path)}"
  end
end

class Scraper
  def self.run(page)
    Browser.open(page) do |driver|
      {
        artworks: GoogleArtworks.scrape(driver)
      }
    end
  end

  def self.dump_html(page)
    Browser.open(page, &:page_source)
  end
end

class GoogleArtworks
  def self.scrape(driver)
    carousel = driver.find_element(:css, 'g-scrolling-carousel')

    carousel.find_elements(:css, 'a').map do |item|
      {
        name: item.attribute('aria-label')&.chomp,
        extensions: item.find_elements(:css, '.klmeta').map { |ext| ext.text&.chomp },
        link: item.attribute('href')&.chomp,
        image: item.find_element(:css, 'img').attribute('src')&.chomp
      }
    end
  rescue Selenium::WebDriver::Error::NoSuchElementError # no carousel
    []
  end
end
