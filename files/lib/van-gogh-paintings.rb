# van-gogh-paintings.rb
# Ruby script for scraping data from the carousel component of a Google Search Results page
# Specifically developed to be used with the provided "van-gogh-paintings.html" file

require "selenium-webdriver"
require "json"

# Create a struct to represent each item in the carousel
# :name -> String; Title of the carousel item
# :extensions -> Array; Contains any meta data pertaining to the item
# :link -> String; Corresponding google search link
# :img -> String; Image source URL
CarouselItem = Struct.new(:name, :extensions, :link, :img)

# Main function for scraping data from Google Search carousel
# source -> String; File Path or website URL
# Return: carousel_hash -> Array of hashes of key data from Carousel Items
def carousel_scrape(source)

    # Configure Chrome WebDriver to run in headless mode
    # Allows scraping of any dynamic content (in this case the image sources)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("--headless")

    # Initializing the webdriver with options created above
    driver = Selenium::WebDriver.for :chrome, options: options

    # Use webdriver to open the HTML file 
    driver.get(source)

    # Create an array of HTML Node objects with the klitem class
    kl_items = driver.find_elements(:css, ".klitem")

    # Initialize an array of carousel item structs
    carousel_items = []

    # Loop through the carousel items and identify key attributes
    # Creates a CarouselItem struct to hold key data
    kl_items.each do |kl_item|
        name = kl_item.attribute("aria-label")
        link = "https://www.google.com/" + kl_item.attribute("href")
        img = kl_item.find_element(:css, "img").attribute("src")
        extensions = []

        kl_item.find_elements(:css, ".klmeta").each do |kl_meta|
            extensions.push(kl_meta.text)
        end

        carousel_items.push(
            CarouselItem.new(
                name,
                extensions,
                link,
                img
            )
        )
    end

    # Close the driver
    driver.quit

    # Generate a hash array from the Carousel Items Array, to be used to create a JSON file
    carousel_hash = carousel_items.map { |e| Hash[e.each_pair.to_a] };

    return carousel_hash

end

# Helper function for scraping data from Google Search carousel with an HTML filename
# filename -> String; HTML filename
# Return: carousel_hash -> Array of Hashes of key data from Carousel Items
def carousel_scrape_HTML(filename)

    # Find the path for the correct HTML file and
    path = "file://" + File.expand_path(filename)

    # Call carousel_scrape using the path string
    carousel_hash = carousel_scrape(path)

    return carousel_hash
end

# Scraping carousel data from the local file van-gogh-paintings.html
# Return: carousel_hash -> Hash Array of key data from Carousel Items
def van_gogh_carousel_scrape()

    # Call carousel_scrape_HTML using the filename 
    carousel_hash = carousel_scrape_HTML("van-gogh-paintings.html")

    return carousel_hash

end

# Scrapes carousel data from the local file van-gogh-paintings.html
# Outputs a JSON file of results
def van_gogh_carousel_scrape_JSON()
    # Convert the hash array to a JSON object and pretty print the object to a JSON file
    File.write('./van-gogh-paintings.json', JSON.pretty_generate(van_gogh_carousel_scrape))
end
