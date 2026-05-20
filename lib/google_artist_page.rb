# frozen_string_literal: true

require 'json'
require 'nokogiri'

Artwork = Struct.new('Artwork', :name, :extensions, :link, :image)

# Representation of a Google search page for an artist
class GoogleArtistPage
  def initialize(file_path)
    @file_path = file_path
  end

  def artworks
    @artworks ||= page.css('.kp-wholepage div[data-attrid^="kc"] a:has(img)')
                      .map do |node|
                        text_arr = node.search('text()').map(&:text)
                        name = text_arr.shift
                        extensions = text_arr unless text_arr.empty?
                        link = "https://www.google.com#{node.attr('href')}" if node.attr('href')
                        image = get_image(node, page)

                        Artwork.new(name:, extensions:, link:, image:)
                      end
  end

  def artworks_json
    artworks
      .map(&:to_h)
      .map(&:compact)
      .then do |arr|
        JSON.pretty_generate({ artworks: arr })
      end
  end

  private

  def page
    @page ||= File.open(@file_path)
                  .then do |file|
                    Nokogiri::HTML(file)
                  end
  end

  def get_image(node, page)
    image_el = node.css('img').first

    image = image_el.attr('data-src')

    if image.nil?
      id = image_el.attr('id')
      image_ref = page.css('script').find { |element| element.text.include?(id) }
      image = image_ref.text.match(/(data:image[^']+)/)&.to_s
    end

    image.gsub('\x3d', '=')
  end
end
