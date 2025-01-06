require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'
require 'json'

class CarouselExtractor
  attr_reader :url, :base_url

  def initialize(url, base_url)
    @url = url
    @base_url = base_url
  end

  def call
    rendered_html = fetch_rendered_html

    doc = Nokogiri::HTML(rendered_html)

    elements_with_img = extract_elements_with_img(doc)
    parent_with_imgs = find_parent_with_most_imgs(elements_with_img)

    return JSON.pretty_generate({}) unless parent_with_imgs

    carousel_name = extract_carousel_name(parent_with_imgs)
    carousel_items = build_carousel_data(doc, parent_with_imgs)

    output = { carousel_name => carousel_items }
    JSON.pretty_generate(output)
  end

  private

  def fetch_rendered_html
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    options.add_argument('--no-sandbox')

    driver = Selenium::WebDriver.for(:chrome, options: options)
    begin
      driver.get(url)

      # Wait until the page is fully loaded
      wait = Selenium::WebDriver::Wait.new(timeout: 15) # Adjust timeout as needed
      wait.until { driver.execute_script("return document.readyState === 'complete'") }

      sleep 1 # Allow time for JavaScript to execute
      driver.page_source
    ensure
      driver.quit
    end
  end

  def extract_elements_with_img(doc)
    doc.css('*').select do |element|
      text_nodes = extract_text_nodes(element)
      element.css('img').size == 1 &&
        element.css('a').size == 1 &&
        text_nodes.size == 2
    end
  end

  def find_parent_with_most_imgs(elements_with_img)
    ancestor_count = Hash.new(0)

    elements_with_img.each do |element|
      ancestor = element.parent
      ancestor_count[ancestor] += 1 if ancestor
    end

    ancestor_count.max_by { |_, count| count }&.first
  end

  def extract_carousel_name(parent_element)
    previous_text = extract_text_node(parent_element)
    current_text = previous_text

    while parent_element.parent && current_text == previous_text
      parent_element = parent_element.parent
      previous_text = current_text
      current_text = extract_text_node(parent_element)
    end
    
    current_text.strip.downcase.gsub(/\s+/, '_').gsub(/[^a-z0-9_]/, '')
  end

  def extract_text_node(element)
    extract_text_nodes(element).first
  end

  def extract_text_nodes(element)
    element.xpath('.//text()').map(&:text).map(&:strip).reject(&:empty?)
  end

  def make_absolute_link(relative_link)
    return relative_link if relative_link.start_with?('http')

    URI.join(base_url, relative_link).to_s
  end

  def build_carousel_data(doc, parent_element)
    parent_element.children.each_with_object([]) do |child, items|
      img = child.at_css('img')
      a = child.at_css('a')
      next unless img && a

      text_nodes = extract_text_nodes(child)
      name = text_nodes.first
      extensions = text_nodes[1..] || []

      items << {
        name: name || img['alt'],
        link: make_absolute_link(a['href']),
        image: extract_image_data(doc, img['id']) || img['data-src'] || img['src']
        # image: img['src']
      }.tap do |hash|
        hash[:extensions] = extensions if extensions&.any?
      end
    end
  end

  def extract_image_data(doc, img_id)
    script_tag = doc.css('script').find { |script| script.children.text.include?("var ii=['#{img_id}']") }
    return nil unless script_tag

    # Match the image data corresponding to the given img_id
    script_content = script_tag.text
    encoded_string = script_content[/data:image[^']+/] if script_content
    decoded_string = encoded_string.gsub('\\x3d', '=')
  end
end

# Example code to use the `CarouselExtractor` service directly:
# url = 'file:///path/to/your/html/file.html'
# base_url = 'https://www.google.com'
# extractor = CarouselExtractor.new(url, base_url)
# output = extractor.call
# puts output