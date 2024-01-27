require_relative '../boot'
require 'selenium-webdriver'
require 'pry'
require 'base64'

class Fetcher
  def initialize(file)
    @file = file
  end

  def data_file_url
    @data_file_url ||= begin
      str = File.read(@file)
      encoded = Base64::encode64(str)

      "data:text/html;base64,#{encoded}"
    end
  end

  def driver
    @driver ||= begin
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument("--headless")
      driver = Selenium::WebDriver.for(:chrome, options: options)
    end
  end

  def rendered
    driver.get(data_file_url)
    driver.execute_script("document.contentType = 'text/html';")
    driver.page_source
  end
end

if __FILE__ == $PROGRAM_NAME
  url = File.expand_path(File.join(File.dirname(__FILE__), "../files/van-gogh-paintings.html"))
  instance = Fetcher.new(url)
  puts instance.rendered
end