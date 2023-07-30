# frozen_string_literal: true

require 'selenium-webdriver'

class BrowserNavigator
  def initialize(url: '')
    @url_target = url
    @page_content = ''
    access_url
  end

  def get_content
    @page_content
  end

  private

  def access_url
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    driver = Selenium::WebDriver.for :chrome, options: options
    driver.navigate.to @url_target
    @page_content = driver.page_source
  end
end
