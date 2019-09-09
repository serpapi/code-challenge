require 'selenium-webdriver'

# puts [{name: 'asdf'}].all? { |hash| (hash[:name].is_a? String) && hash[:name].present? }
# return

# if 'files/Van-gogh-paintings.html' =~ /van.?gogh.?paintings/i
#   puts 1
# end
# return

class Browser
  attr_accessor :headless
  attr_reader :driver

  def initialize(headless=false)
    @headless = headless
    @driver = nil
  end

  def start_driver
    # options = Selenium::WebDriver::Chrome::Options.new(args: switches)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("--ignore-certificate-errors")
    options.add_argument("--disable-web-security")

    if @headless
      options.add_argument("--headless")
      options.add_argument("--no-sandbox")
      options.add_argument("--disable-gpu")
      options.add_argument("--disable-software-rasterizer")
    end

    @driver = Selenium::WebDriver.for(:chrome, options: options)

    # Cleanup on exit
    at_exit do
      @driver.quit
    end
  end
end

def get_carousel(browser, url)
  puts "Opening #{url}"
  browser.driver.navigate.to(url)

  # carousel_elements = browser.driver.find_elements(:xpath, "//div[@class='klbar']//g-scrolling-carousel//a[@class='klitem']")
  # just in case, wait for the carousel to load first
  wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  carousel_elements = wait.until { browser.driver.find_elements(:xpath, "//div[@class='klbar']//g-scrolling-carousel//a[@class='klitem']") }

  artworks = []
  idx = 0
  carousel_elements.each do |carousel_e|
    #   {
    #      name,
    #      extensions (optional),
    #      link,
    #      image
    #   }
    artwork = {}
    artwork[:name] = carousel_e.find_element(:xpath, ".//div[@class='kltat']").text.chomp

    # Presumably, there can be either none, one or multiple extensions with the same class
    extensions_elements = carousel_e.find_elements(:xpath, ".//div[@class='ellip klmeta']")
    # puts "extensions_elements: #{artwork[:name]}: #{extensions_elements}"
    if !extensions_elements.empty?
      artwork[:extensions] = []
      extensions_elements.each do |extension_e|
        artwork[:extensions].push(extension_e.text.chomp)
      end
    end

    artwork[:link] = carousel_e.attribute('href').chomp  # We are already on  the anchor element, so grab its href

    # There's always a single thumbnail in the carousel, so grab the first img with data-src
    # If an off-screen thumbnail hasn't loaded then we have to use data-src, otherwise use src
    begin
      image_e = carousel_e.find_element(:xpath, ".//img[@src]")
      image_src = image_e.attribute('src').chomp
    rescue Selenium::WebDriver::Error::NoSuchElementError, Timeout::Error
      image_e = carousel_e.find_element(:xpath, ".//img[@data-src]")
      image_src = image_e.attribute('data-src').chomp
    end
    artwork[:image] = image_src

    puts "#{idx+1}: #{artwork[:name]}"
    idx += 1

    artworks.push(artwork)
  end
  return artworks
end
