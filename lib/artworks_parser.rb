require 'nokogiri'
require 'pry'
require_relative 'artwork'

class ArtworksParser
  def initialize(html)
    page = Nokogiri::HTML(html)
    @images = parse_images(html)
    @artworks_component = page.css('div#extabar g-scrolling-carousel')
  end

  def artworks
    @artworks_component.css('.klitem-tr a').each_with_index.map do |artwork_container_link, index|
      artwork_name = artwork_container_link.attribute('aria-label').value
      link = artwork_container_link.attribute('href').value
      link = link.include?('google.com') ?  link : "https://www.google.com#{link}"
      extensions = artwork_container_link.css('.klmeta').text.split(',')

      Artwork.new(
        name: artwork_name,
        link: link,
        image: @images[index],
        extensions: extensions
      )
    end
  end

  private

  def parse_images(html)
    regex = /var s\='data:image\/jpeg;base64,(\S+)?';/
    html.scan(regex).map { |image_content| "data:image/jpeg;base64,#{image_content.first}" }
  end
end