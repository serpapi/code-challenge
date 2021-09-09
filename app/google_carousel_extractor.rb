require 'watir'
require 'nokogiri'
require 'uri'
require 'open-uri'

class GoogleCarouselExtractor
  DOMAIN_NAME = "www.google.com"

  def extract_from_file(file_path)
    browser = Watir::Browser.new
    browser.goto "file://" + file_path
    extract(Nokogiri::HTML(browser.html))
  end
  
  def extract_from_url(url)
    content = URI.open(url, 
      "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5)AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.1.1 Safari/605.1.15"
    )
    extract(Nokogiri::HTML(content))
  end

  def extract(html)
    result = []
    html.xpath("//a[contains(@class, 'klitem')]").each do |node|
      result << parse_item_node_to_object(node)
    end
    result
  end

  def parse_item_node_to_object(node)
    result = {}

    # Name
    result[:name] = node.attribute('aria-label').to_s

    # Extensions
    # title attribute always contains "name (extension)", so use aria-label (which only contains name) to replace
    # the name in title attribute. This can prevent error when name consist of () 
    titleWithOnlyPotentialExtension = node.attribute("title").to_s.gsub! node.attribute("aria-label").to_s, ""
    potentialExtension = titleWithOnlyPotentialExtension.to_s.scan(/\s\((.*)\)/)
    extension = potentialExtension.last ? node.attribute("title").to_s.scan(/\s\((.*)\)/).last.first : ""
    result[:extensions] = [extension] unless extension.empty?

    # Image
    result[:image] = nil
    image = node.css('g-img img').attribute('src').to_s
    result[:image] = image unless image.empty?

    # Link
    result[:link] = node.attribute('href').to_s
    unless result[:link].include?(DOMAIN_NAME)
      result[:link] = "https://" + DOMAIN_NAME + result[:link]
    end

    result
  end
end