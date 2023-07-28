require 'watir'
require 'nokogiri'

chrome_binary_path = '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'

Selenium::WebDriver::Chrome.path = chrome_binary_path

browser = Watir::Browser.new(:chrome)

def parse_google_search_results(search_query, browser)
    browser.goto('https://www.google.com')

    sleep(4)
    
    button = browser.button(id: 'L2AGLb')
    button.click

    sleep(2)

    search_input = browser.textarea(name: 'q')
    search_input.set(search_query)
    search_input.send_keys(:enter)

    sleep(4)
  
    page_html = browser.html

    doc = Nokogiri::HTML(page_html)
    search_results = []
    
    result_elements = doc.css('div.iELo6')

    result_elements.each do |result_element|
        extensions = []
        
        a_element = result_element.at('a')
        div_element = a_element.at('div')

        title = div_element.css('div')[0].text
        extensions << div_element.css('div')[1].text
        link = "https://www.google.com" << a_element['href']
        image = a_element.at('img')['src']

        search_results << { "name": title, "extensions": extensions, "link": link, "image": image }
    end

    browser.close
    
    search_results
end

results = parse_google_search_results("Van Gogh paintings", browser)

puts results