require 'json'
require 'ferrum'
require 'byebug'
class ArtworkGalleryParser
  GOOGLE_SEARCH_BASE_URL = 'https://www.google.com'
  
  def initialize()
    # Using Ferrum to make JavaScript do its thing - replace image.src placeholder with actual image
    @browser = Ferrum::Browser.new(headless: true)
  end

  def parse(url)
    page = @browser.create_page
    page.go_to(url)

    gallery_items(page).map do |element|
      image_element = gallery_item_image_element(element)

      {
        # id:         image_element['id'], # for debugging purposes
        name:       image_element['alt'],
        extensions: gallery_item_extensions(element),
        link:       gallery_item_link(element),
        image:      image_src(image_element)
      }.reject { |_, v| v.nil? || v.empty? }
    end
  end
  
  private

  def gallery_items(page)
    # links that refer to search results and have images
    page.css('div[data-attrid="kc:/visual_art/visual_artist:works"] a[href^="/search?sca_esv"]')
  end

  # TODO: consider using classes and factories GalleryItem, GalleryImage.from_gallery_item, GalleryLink.from_gallery_item
  # mind not to overengineer
  def gallery_item_image_element(element)
    element.at_css('img[src^="data:image"]')
  end

  def image_src(image_element)
    data_src = image_element.attribute('data-src')
    src = image_element['src']

    data_src || src
  end

  def gallery_item_link(element)
    "#{GOOGLE_SEARCH_BASE_URL}#{element.attribute('href')}"
  end

  def gallery_item_name(element)
    element.xpath('./div/div')&.first&.text
  end

  def gallery_item_extensions(element)
    element.xpath('./div/div')[1..-1].map { |e| clean_text(e&.text) }.compact.reject(&:empty?)
  end

  def clean_text(text)
    text.to_s.gsub(/\s+/, ' ').strip
  end
end

# Usage
if __FILE__ == $0
  url = File.expand_path(ARGV.first)
  parser = ArtworkGalleryParser.new
  paintings = parser.parse("file://#{url}")
  puts JSON.pretty_generate(artworks: paintings)
end