require 'selenium-webdriver'

# TODO:
# - separate the Selenium logic from the parsing logic
class PaintingsExtractor
  def initialize(file_path)
    @file_path = file_path
    @driver = Selenium::WebDriver.for(:chrome, options: selenium_options)
  end

  def extract_paintings
    paintings = []

    with_html_loaded do
      @driver.find_elements(css: ITEM_SELECTOR).each do |painting|
        paintings << {}.tap do |h|
          puts "Parsing #{painting.attribute('aria-label')}"

          h['name'] = painting.attribute('aria-label')
          h['extensions'] = extract_extensions(painting)
          h['link'] = extract_google_href(painting)
          h['image'] = parse_image_url(painting)
        end
      end
    end

    paintings
  end

  private

  ITEM_SELECTOR = 'a.klitem'.freeze
  SELENIUM_SECONDS_TIMOUT = 2
  private_constant :ITEM_SELECTOR, :SELENIUM_SECONDS_TIMOUT

  def parse_image_url(painting)
    image_element = painting.find_element(css: 'img')
    image_url = image_element.attribute('src')

    return image_url unless image_url&.start_with?('data:image/gif')

    image_element.attribute('data-src') || image_element.attribute('data-original') || image_url
  end

  def extract_google_href(painting)
    slug = painting.attribute('href')
    return nil if slug.nil? || slug.strip.empty?

    slug = slug.sub(%r{^file://[^/]*}, '')
    "https://www.google.com#{slug}"
  end

  def extract_extensions(painting)
    [painting.find_element(css: 'div.klmeta').text]
  rescue Selenium::WebDriver::Error::NoSuchElementError
    []
  end

  def with_html_loaded
    @driver.get("file://#{File.expand_path(@file_path)}")
    wait = Selenium::WebDriver::Wait.new(timeout: SELENIUM_SECONDS_TIMOUT)
    wait.until { @driver.find_elements(css: ITEM_SELECTOR).any? }

    yield

    @driver.quit
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