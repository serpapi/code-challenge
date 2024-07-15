# frozen_string_literal: true

require 'selenium-webdriver'

class WebPageLoader
  SELENIUM_SECONDS_TIMEOUT = 2
  private_constant :SELENIUM_SECONDS_TIMEOUT

  def initialize(file_path, wait_for_item_to_render)
    @file_path = file_path
    @driver = Selenium::WebDriver.for(:chrome, options: selenium_options)
    @wait_for_item_to_render = wait_for_item_to_render
  end

  def html
    load_html if @driver.page_source.empty?

    @driver.page_source
  end

  def with_html_loaded
    load_html

    yield

    @driver.quit
  end

  private

  def load_html
    @driver.get("file://#{File.expand_path(@file_path)}")
    wait = Selenium::WebDriver::Wait.new(timeout: SELENIUM_SECONDS_TIMEOUT)
    wait.until { @driver.find_elements(css: @wait_for_item_to_render).any? }

    @driver.page_source
  end

  def selenium_options
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options
  end
end
