# frozen_string_literal: true

require 'json'
require 'nokogiri'
require 'selenium-webdriver'

# Represents a blank 1x1 GIF image
# Returned in initial page load by Google Search before image thumbnails have been populated by JavaScript
EMPTY_BASE64_GIF = 'data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=='

module SerpAPI
  ##
  # This class contains Google Search-related methods for the code challenge.
  class GoogleSearch
    ##
    # Creates a new SerpAPI::GoogleSearch instance
    #
    # NOTE: Real SerpAPI puts the search request parameters in the args. However,
    # I put them in `get_hash` for the purpose of this code exercise since it
    # allows one to reuse a single instance of Selenium, saving on
    # startup/resources.
    def initialize
      @driver = make_web_driver
    end

    ##
    # Obtains the result hash for the google search.
    #
    # NOTE: Unlike SerpAPI code this requires the HTML file with the results to parse (optimization)
    # Also only inline images are returned for the code challenge purpose.
    #
    # @param [String] html_file Path to an HTML file to parse
    # @return [Hash] Parsed results
    def get_hash(html_file)
      page = fetch(html_file)

      {
        'knowledge_graph' => knowledge_graph(page)
      }
    end

    private

    ##
    # Creates and configures the Selenium web driver.
    #
    # @return [Selenium::WebDriver]
    def make_web_driver
      options = Selenium::WebDriver::Chrome::Options.new.tap do |o|
        o.add_argument('--headless')
        o.add_argument('--no-sandbox') # initial browser startup times out unless this is added
      end

      # Increase timeouts to avoid exceptions on Selenium startup
      Selenium::WebDriver.for(:chrome, options: options).tap do |d|
        d.manage.timeouts.implicit_wait = 120
        d.manage.timeouts.script_timeout = 120
        d.manage.timeouts.page_load = 120
      end
    end

    ##
    # Fetches the webpage for Google Search using Selenium.
    # We must use Selenium because the page runs some clientside Javascript on load that for example
    # changes the img elements to have the correct base64-encoded thumbnails.
    #
    # @param [String] html_file Path to an HTML file to parse
    # @return [Nokogiri::XML::Node] Nokogiri parsed page
    def fetch(html_file)
      @driver.get("file:///#{html_file}")
      Nokogiri::HTML5(@driver.page_source)
    end

    ##
    # Returns knowledge graph information from the search results page (only artworks, this time)
    #
    # @param [Nokogiri::XML::Node] page Nokogiri parsed page
    # @return [Hash] Parsed results under "knowledge_graph" category
    def knowledge_graph(page)
      # This this the HTML for the entries under the "Artworks" tab of the
      # knowledge graph search widget at top of results.
      works_container = page.css('[data-attrid="kc:/visual_art/visual_artist:works"] > .xac7Kb > .Cz5hV > .iELo6')
      artworks = works_container.map(&method(:parse_artwork))

      {
        'artworks' => artworks
      }
    end

    def parse_artwork(work)
      link = work.at('a')
      image = link.at('img')

      # When loading the raw page, the image thumbnails `src` attribute in the
      # knowledge graph section are set to a blank 1x1 GIF. After the inline
      # JavaScript executes, the thumbnails will be replaced with the full
      # base64-encoded image. However, the thumbnails not visible on the page
      # (hidden under "More...") will still be set to 1x1 GIFs. In that case,
      # use the `data-src` attribute for the `image` property as it gives a URL
      # (https://encrypted-tbn2.gstatic.com) pointing to the thumbnail.
      image_src = image.attr('src')
      image_src = image.attr('data-src') if image_src == EMPTY_BASE64_GIF

      result = {
        'name' => image.attr('alt'),
        'link' => "https://www.google.com#{link.attr('href')}",
        'image' => image_src
      }

      # Some of the images may not have a year included, in that case do not add
      # any `extensions` to the result array
      extensions = work.css('.cxzHyb').map { |ext| ext.inner_html.to_s }.reject(&:empty?)
      result['extensions'] = extensions unless extensions.empty?

      result
    end
  end
end
