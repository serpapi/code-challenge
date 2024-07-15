require 'selenium-webdriver'
require 'nokolexbor'

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
      html_doc.css(ITEM_SELECTOR).each do |painting|
        extensions = extract_extensions(painting)

        paintings << {}.tap do |h|
          h['name'] = painting.attribute('aria-label').to_s
          h['extensions'] = [extensions] unless extensions.nil? || extensions.empty?
          h['link'] = extract_google_href(painting)
          h['image'] = extract_image_data(painting)&.to_s
        end
      end
    end

    { 'artworks' => paintings }
  end

  private

  ITEM_SELECTOR = 'a.klitem'.freeze
  SELENIUM_SECONDS_TIMOUT = 2
  private_constant :ITEM_SELECTOR, :SELENIUM_SECONDS_TIMOUT

  def html_doc
    @html_doc ||= Nokolexbor::HTML(@driver.page_source)
  end

  def extract_image_data(painting)
    image_element = painting.css('img')
    image_id = image_element.attr('id')&.value

    image_data_map[image_id]
  end

  def extract_google_href(painting)
    slug = painting.attribute('href')
    return nil if slug.nil?

    "https://www.google.com#{slug}"
  end

  def extract_extensions(painting)
    painting.css('div.klmeta').text.strip
  end

  def image_data_map
    @image_data_map ||= begin
      scripts = html_doc.css('script')

      scripts.each_with_object({}) do |script, map|
        script.text.scan(/var\s*s\s*=\s*'([^']*)'.*?var\s*ii\s*=\s*\['([^']*)'\]/m) do |s, ii|
          map[ii] = s.gsub('\\', '')
        end
      end
    end
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