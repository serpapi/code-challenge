
class Scraper
  def self.scrape_data(url)
    # Use Nokogiri to parse the HTML
    doc = Nokogiri::HTML(URI.open(url))
    results = scrape_carousel_data(doc)
    { 'artworks' => results }
  end

  private

  def self.scrape_carousel_data(doc)
    # Initialize an array to store the scraped data
    results = []

    # Select the jsslot div inside the g-scrolling-carousel element
    carousel = doc.at_css('g-scrolling-carousel div[jsslot]')
    if carousel
      # Select child elements within the parent div
      child_elements = carousel.css('> *')

      # Iterate over the child elements
      child_elements.each do |element|
        tag_name = element.name

        case tag_name
        when 'div'
          # handle for <div>
          name, year, href_value, base64_image = handle_div_element(doc, element)
        else
          # handle for <a>
          name, year, href_value, base64_image = handle_anchor_element(doc, element)
        end
        # Create the result object
        result_obj = {}
        result_obj['name'] = name
        result_obj['extensions'] = [year] unless year.nil? # Add 'extensions' key only if year is not null
        result_obj['link'] = "https://www.google.com#{href_value}"
        result_obj['image'] = base64_image

        # Add the result object to the results array
        results << result_obj
      end
    end
    results
  end

  # Handle div element selection
  def self.handle_div_element(doc, element) 
    link = element.at_css('a')
    if link
      href_value = link['href']

      image_container = link.css('div')[1]
      if image_container
        # Select the <img> tag within the first <div>
        img_tag = image_container.css('img')[0]
        id_attribute = img_tag['id']
        # Extract base64 image with the id_attribute
        base64_image = extract_base64_image(doc, id_attribute)
      end

      # Select the second <div> inside the current <a> tag
      text_container = link.css('div')[2]
      if text_container
        # Get the text content of the first <div> as 'name'
        name = get_div_text(text_container, 0)
        # Get the text content of the second <div> as 'year'
        year = get_div_text(text_container, 1)
      end
    end
    [name, year, href_value, base64_image]
  end

  # Handle anchor element selection
  def self.handle_anchor_element(doc, element) 
    link = element
    if link
      href_value = link['href']

      image_container = link.css('div')[1]
      if image_container
        # Select the <img> tag within the first <div>
        img_tag = image_container.css('img')[0]
        id_attribute = img_tag['id']
        # Extract base64 image with the id_attribute
        base64_image = extract_base64_image(doc, id_attribute)
      end

      text_container = link.css('div')[4]
      if text_container
        name = get_div_text(text_container, 1)
        year = get_div_text(text_container, 4)
      end
    end
    [name, year, href_value, base64_image]
  end

  # Extract the base64 image using the id attribute
  def self.extract_base64_image(doc, id_attribute)
    # Find the script tag that contains the desired ii value
    script_tag = doc.at_xpath("//script[contains(text(), \"var ii=['#{id_attribute}']\")]")
    if script_tag
      # Extract the base64 image from the script tag
      base64_image = script_tag.content.scan(/'([^']+)'/).flatten.first
    end
    base64_image
  end

  # Get the text content of a specified div index
  def self.get_div_text(div, index)
    div.css('div')[index]&.text
  end
end