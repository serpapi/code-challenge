require 'rspec'
require 'watir'
require 'nokogiri'
require_relative '../parse_google_search'

RSpec.configure do |config|
  config.before(:all) do
    chrome_binary_path = '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
    Selenium::WebDriver::Chrome.path = chrome_binary_path
    @browser = Watir::Browser.new(:chrome)
  end

  config.after(:all) do
    @browser.close
  end
end