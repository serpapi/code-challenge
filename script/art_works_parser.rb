# frozen_string_literal: true

require 'nokogiri'
require 'json'
require 'open-uri'

class ArtWorksParser
  URL = 'https://www.google.com'
  IMAGES_REGEX = %r{var s='data:image/jpeg;base64,([a-zA-Z0-9+/\\]+)?'}.freeze

  def initialize(path)
    @path = path
    @file = File.open(path) { |f| Nokogiri::HTML(f) }
    @result = { artworks: [] }
  end

  def parse
    file.css('.klitem').each_with_index do |html, index|
      @html = html
      write_result(index)
    end

    result.to_json
  rescue StandardError => e
    puts "Exception Occurred #{e.class}."
    puts "Message: #{e.message}. Backtrace:  \n #{e.backtrace.join("\n")}"
  end

  private

  attr_reader :file, :result, :html, :path

  def read_name
    html.at_css('.kltat').content
  end

  def read_image(index)
    return unless images[index]

    "data:image/jpeg;base64,#{images[index][0]}"
  end

  def read_extensions
    html.at_css('.klmeta')&.text&.split
  end

  def read_link
    href = html.attr('href') || html.ancestors('a').attr('href')
    URI.join(URL, href).to_s
  end

  def images
    @images ||= File.read(path).scan(IMAGES_REGEX)
  end

  def write_result(index)
    result[:artworks][index] = {
      name: read_name,
      extensions: read_extensions,
      link: read_link,
      image: read_image(index)
    }
  end
end
