# frozen_string_literal: true

# Scrape a Google g-scrolling-carousel from the given nokogiri/nokolexbor object
class GoogleCarouselScraper
  include Enumerable

  attr_reader :doc

  def initialize(doc)
    @doc = doc
  end

  # iterate over each g-scrolling-carousel in the given document, if any
  def each
    return enum_for(:each) unless block_given?

    image_by_id = embedded_images_by_id(doc)

    doc.css('g-scrolling-carousel').each do |carousel|
      contents = scrape_carousel(carousel, image_by_id)

      yield(contents) if contents.any?
    end
  end

  private

  # Extract the contents of a single g-scrolling-carousel from the given node
  #
  # Returns an array of hashes
  def scrape_carousel(carousel, image_by_id = {})
    carousel.css('a[href][aria-label], a[href][data-original-name]').filter_map do |a|
      # Ensure URL is absolute
      # TODO: This should be parameterised based on the source URL
      link = a['href']
      link = 'https://www.google.com' + link unless link.start_with?('http:', 'https:')

      {
        'name' => a['aria-label'] || a['data-original-name'],
        'link' => link,
        'image' => image_by_id[a.at_css('img[id]')&.attr('id')],
      }.tap do |ret|
        # We can have a nil image, but no empty extensions arrays
        extensions = a.css('.ellip.klmeta').map(&:inner_text).reject(&:empty?)
        ret['extensions'] = extensions if extensions.any?
      end
    end
  end

  # Extract images embedded in <script> tags of the form:
  #
  # var s='data:image/jpeg;base64,...';var ii=['id'];_setImagesSrc(ii,s);
  #
  # Returns a Hash of element ID to data URI embedded image
  def embedded_images_by_id(doc)
    doc.css('script').flat_map do |script|
      # Note base64 padding is escaped as '\x3d', so we also match on backslash.
      script
        .inner_text
        .scan(%r{'(data:image/jpeg;base64,[a-zA-Z0-9/+\\]+)';var ii=\['([^']+)'\]})
        .map do |data, id|
          # Decode escaped characters of the form \xFF
          # This is more general than we really need, and should probably only
          # accept valid base64 characters anyway
          # data.gsub!(/\\x([a-f0-9]{2})/) { $1.to_i(16).chr }

          # Simpler and ensures we only decode what we expect
          data.gsub!('\x3d', '=')
          [id, data]
        end
    end.to_h
  end
end
