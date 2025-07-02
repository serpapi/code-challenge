# frozen_string_literal: true
require 'nokogiri'
require 'uri'

module Extractor
  class Error < StandardError; end

  # Relevant script tags end with this i.e. statement that sets the src of the lazy loaded images.
  SCRIPT_MARKER = '_setImagesSrc(ii,s'
  IMAGE_DATA_REGEX = Regexp.new(/var s='(.*?)';/)
  IMAGE_ID_REGEX = Regexp.new(/var ii=\['(.*?)'\];/)

  # Google serp has images that are lazily rendered, their data is stored in
  # variables in the script tags in base64 encoding. The tags contain ids for
  # their respective images. At runtime these scripts replace the src attribute
  # of their images with the base64 encoded data. This function go to all of
  # these script tags and collects the image ids and their base64 encoded data.
  # Script tags look like this (prettified):
  # ```js
  # (function() {
  #   var s = 'image data encoded in base64';
  #   var ii = ['image-id'];
  #   var r = ''; // may be omitted
  #   _setImageSrc(ii, s, r); // 'r' may be omitted
  # })();
  # ```
  # @param doc [Nokogiri::HTML::Document] The parsed HTML document containing the script tags.
  # @return [Hash] A hash where keys are image IDs and values are the base64 encoded image data.
  def self.collect_lazy_images(doc)
    images = {}

    doc.search('script').each do |script|
      next unless script.text.include?(SCRIPT_MARKER)

      id_match = script.text.match(IMAGE_ID_REGEX)
      if id_match.nil? || id_match[1].nil? || id_match[1].empty?
        warn("Script tag is missing image ID: #{script.text.inspect}")
        next
      end
      image_id = id_match[1]

      data_match = script.text.match(IMAGE_DATA_REGEX)
      if data_match.nil? || data_match[1].nil? || data_match[1].empty?
        warn("Script tag is missing base64 data: #{script.text.inspect}")
        next
      end
      # Un-escape the padding '=' characters in the base64 string from '\\x3d' to '='
      image_data = data_match[1].gsub("\\x3d", '=')

      # Store the base64 data with the corresponding image ID
      images[image_id] = image_data
    end

    images
  end

  # CSS selectors for extracting artworks from the Google knowledge panel.

  ARTWORK_CONTAINER_ANCHOR_SELECTOR = 'div.iELo6 > a'
  ARTWORK_NAME_SELECTOR = 'div.pgNMRc'
  ARTWORK_YEAR_SELECTOR = 'div.cxzHyb'
  ARTWORK_IMAGE_SELECTOR = 'img.taFZJe'

  GOOGLE_BASE_URL = 'https://www.google.com'

  # Extracts artworks from the artwork knowledge panel in a Google search results page.
  # Structure:
  # <div class="iELo6">
  #   <a href="{relativeURL}">
  #     <img
  #             id="for images with lazy rendering"
  #             class="taFZJe"
  #             src="base64 placeholder"
  #             data-src="remote url for image below the fold" alt="{name}"
  #             data-deferred="1 - for images with lazy rendering"
  #     // {...other attributes}
  #     />
  #     <div class="KHK6lb">
  #       <div class="pgNMRc">{name}</div>
  #       <!-- optional year -->
  #       <div class="cxzHyb">{year}</div>
  #     </div>
  #   </a>
  # </div>
  # @param html [String] The HTML content of the Google search results page.
  # @return [Array<Hash>] An array of hashes, each containing details of an artwork.
  def self.extract_artworks_from_knowledge_panel(html)
    doc = Nokogiri::HTML(html)
    lazy_images = collect_lazy_images(doc)
    artworks = []

    doc.search(ARTWORK_CONTAINER_ANCHOR_SELECTOR).each do |element|
      name = element.at_css(ARTWORK_NAME_SELECTOR).text.strip
      year = element.at_css(ARTWORK_YEAR_SELECTOR).text.strip

      href = element['href']
      unless href.is_a?(String)
        warn("Artwork element is missing href: name=#{name.inspect}")
        next
      end

      image_element = element.at_css(ARTWORK_IMAGE_SELECTOR)
      # Visible artworks only have a src attribute with the base64 encoded
      # image. Hidden artworks in the truncated part of the knowledge panel
      # have a data-src attribute with a remote URL that is fetched and
      # displayed as base64 when the user expands the knowledge panel. We get
      # the remote url from data-src if it exists, otherwise we use the base64
      # encoded image from the src attribute.
      image = lazy_images[image_element['id']] || image_element['data-src']
      unless image.is_a?(String)
        warn("Artwork element is missing image: name=#{name.inspect}")
        next
      end

      if name.empty? || href.empty? || image.empty?
        warn("Artwork element is missing required fields: name=#{name.inspect}, href=#{href.inspect}, image=#{image.inspect}")
        next
      end

      link = URI.join(GOOGLE_BASE_URL, href).to_s

      artwork = {
        name: name,
        link: link,
        image: image,
      }

      unless year.empty?
        artwork[:extensions] = [year]
      end

      artworks.append(artwork)
    end

    artworks
  end

  # @param serp_path [String] The path to the Google search results page HTML file.
  # @return [Array<Hash>] An array of hashes, each containing details of an artwork.
  def self.extract_artworks_from_serp_file(serp_path)
    if serp_path.nil? || serp_path.empty?
      raise ArgumentError, 'Please provide the path to the Google search results page HTML file.'
    end

    begin
      html_content = File.read(serp_path)
      self.extract_artworks_from_knowledge_panel(html_content)
    rescue Errno::ENOENT
      raise Error, "File not found: #{serp_path}"
    rescue StandardError => e
      raise Error, "An error occurred while reading the file: #{e.message}"
    end
  end

end
