# frozen_string_literal: true
require 'httpx'
require 'json'
require 'nokogiri'

# Parse saved Google search HTML files and extract data.
class WebLens
  BASE_URL = 'https://www.google.com'
  GOOGLE_SEARCH_REGEX = /search\?gl=us&hl=en/
  GOOGLE_USER_CONTENT_DOMAIN = /googleusercontent\.com/
  TITLE_AND_SECTIONS_REGEX = /(?<title>(.+)) \((?<extensions>\d{4})\)/ # rubocop:disable Lint/MixedRegexpCaptureTypes
  BLANK_GIF_IMAGE = 'R0lGODlhAQABAIABAAAAAP///yH5BAEAAAEALAAAAAABAAEAAAICTAEAOw=='
  JSON_FILE = './files/google_image_search_results.json'
  SAMPLE_HTML_FILE = './files/paintings.html'

  def parse
    read_html_file

    extract_data_as_json

    write_to_file
  end

  private

  attr_reader :document, :json_data

  def read_html_file(file: SAMPLE_HTML_FILE)
    file = File.read(file)

    @document = Nokogiri::HTML(file)
  end

  def fetch_image_data_url(element)
    url = extract_url_from(element)

    return nil if url.match(GOOGLE_USER_CONTENT_DOMAIN) || url.nil?

    raw_image = fetch_image(url)

    return nil if raw_image == BLANK_GIF_IMAGE

    "data:image/jpeg;base64,#{raw_image}" if raw_image
  end

  def extract_url_from(element)
    element.attribute('data-key')&.value || element.attribute('data-src')&.value
  end

  def fetch_image(url)
    Base64.encode64(HTTPX.get(url).to_s).split("\n").join
  end

  def fetch_title_and_sections_from(element)
    if (data = element.attribute('title').value.match(TITLE_AND_SECTIONS_REGEX))
      title = data[:title]
      extensions = data[:extensions]
    end

    [title, extensions]
  end

  def extract_data_as_json
    contents = document.css('g-scrolling-carousel a').map do |a|
      link = a.attribute('href').value

      next unless link.match(GOOGLE_SEARCH_REGEX)

      title, extensions = fetch_title_and_sections_from(a)

      next unless title || extensions

      { name: title, extensions: [extensions], link: BASE_URL + link, image: fetch_image_data_url(a.css('img')) }
    end

    @json_data = JSON.pretty_generate({ artworks: contents.compact })
  end

  def write_to_file
    File.write(JSON_FILE, @json_data)
  end
end
