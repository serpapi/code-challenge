require 'htmlbeautifier'
require 'nokogiri'
require 'selenium-webdriver'

module Scraper
  extend self

  def nokodoc_via_selenium(url:, pause_for_web_inspector: false, save_source: false)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless') if pause_for_web_inspector
    driver = Selenium::WebDriver.for :chrome, options: options

    driver.get(url)
    driver.manage.timeouts.implicit_wait = 500

    if save_source
      dump_html_to_file(html: driver.page_source, filename: "./html_dumps/selenium.html", beautify: true)
    end
    
    noko_html_doc = Nokogiri::HTML(driver.page_source)

    sleep 2000 if pause_for_web_inspector
    driver.quit

    noko_html_doc
  end

  def scrape(noko_html_doc:)
    carousel = extract_carousel(noko_html_doc: noko_html_doc)

    item_xml_eles = extract_carousel_items(carousel_xml_ele: carousel)

    item_xml_eles.map do |xml_ele|
      { name:       extract_item_title(noko_xml_ele: xml_ele),
        extensions: [extract_item_year(noko_xml_ele: xml_ele)],
        link:       extract_item_href(noko_xml_ele: xml_ele),
        image:      extract_item_img_src(noko_xml_ele: xml_ele) }
    end
  end

  def extract_carousel(noko_html_doc:)
    # We only want the first carousel
    noko_html_doc.xpath('//g-scrolling-carousel')&.first
  end

  def extract_carousel_items(carousel_xml_ele:)
    carousel_xml_ele.xpath('.//*[@class="klitem"]')
  end

  def extract_decendants_with_class(noko_xml_ele:, css_class:)
    # Return a list of nodes where the css class includes <css_class>
    class_include_match = /(^|\s+)#{Regexp.quote(css_class)}($|\s+)/
    descendants = noko_xml_ele.xpath('.//*')
    descendants.select { |d| class_include_match.match?(d&.[]('class')) }
  end

  def extract_item_href(noko_xml_ele:)
    href = noko_xml_ele&.[]('href')&.strip || ''
    href.empty? ? '' : Constants::GOOGLE_BASE_URL + href
  end

  def extract_item_img_src(noko_xml_ele:)
    noko_xml_ele.xpath('.//img').first&.[]('src') || nil
  end

  def extract_item_title(noko_xml_ele:)
    extract_decendants_with_class(noko_xml_ele: noko_xml_ele, 
                                  css_class: 'kltat')&.first&.text&.strip || ''
  end

  def extract_item_year(noko_xml_ele:)
    extract_decendants_with_class(noko_xml_ele: noko_xml_ele, 
                                  css_class: 'klmeta')&.first&.text&.strip || ''
  end
end