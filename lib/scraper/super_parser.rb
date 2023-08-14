module Scraper
  class SuperParser
    def initialize(path)
      @browser = Selenium::WebDriver.for :chrome
      @browser.get path
    end

    def artworks
      { "artworks" => results }
    end

    def results
      @results = extract_data_from_web_page
    end

    private
    def extract_data_from_web_page
      @browser.find_elements(:css, ITEM).map do |item|
        {
          name: item.find_elements(:css,NAME).map{|el| el.attribute('innerHTML')}.join,
          extensions: extensions(item),
          link: link(item),
          image:image(item)
        }
      end
    end

    def extensions(item)
      item.find_elements(:css, EXT)
      extensions = item.find_elements(:css, EXT)
      return if extensions.empty?

      extensions.map{|el| el.attribute('innerHTML')}
    end

    def link(item)
      link = item.dom_attribute('href')
      return unless link

      "https://www.google.com#{item.dom_attribute('href')}"
    end

    def image(item)
      elem = item.find_element(:css, IMG)
      img =  elem.find_elements(:css, 'img').first
      return  unless img

      img.dom_attribute('src')
    end
  end
end
