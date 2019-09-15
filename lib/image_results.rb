require "webdrivers/chromedriver"
require_relative "image_result_entry"

class ImageResults
  attr_reader :agent
  attr_reader :results

  # Filename must be local
  def initialize(filename)
    @agent = create_agent

    agent.get("file://#{filename}")
    wait_for_dom

    @results = parse_results
  end

  def as_json
    { artworks: results.map(&:as_json) }
  end

  private

  def create_agent
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("--headless") unless ENV["NO_HEADLESS"]

    # We want the "eager" strategy, but it requires a very recent chromedriver.
    # Use "none" with an explicit wait for compatibility.
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(page_load_strategy: "none")

    Selenium::WebDriver.for(:chrome,
                            options: options,
                            desired_capabilities: caps)
  end

  # Waits for the page to load just enough for the carousel data to exist
  def wait_for_dom
    Selenium::WebDriver::Wait.new(timeout: 5).until do
      # Google's deferred thumbnail loading luckily sets this "data-atf" property once it
      # has replaced the filler 1x1 gif.  When we see one, we're loaded enough to continue
      
      agent.find_elements(css: "g-scrolling-carousel a.klitem g-img img").any? do |e|
        e.attribute("data-atf") == "1"
      end
    end
  end

  def parse_results
    image_elements = agent.find_elements(css: "g-scrolling-carousel a.klitem")

    image_elements.map do |image_element|
      ImageResultEntry.new(image_element)
    end
  end
end
