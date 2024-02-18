require 'nokogiri'
require 'json'

# Methods shared by both CarouselTypeOne and CarouselTypeTwo
module CarouselSharedMethods
  def get_href(el)
    unless el.is_a?(Nokogiri::XML::Element)
      warn "Expected a Nokogiri::XML::Element but received #{el.class}"
      return nil
    end

    anchor_el = el.css('a').first
    if anchor_el.nil? || anchor_el['href'].to_s.empty?
      nil
    else
      "https://www.google.com#{anchor_el['href']}"
    end
  end

  # Unfortunately, the src value we want is not held by the src
  # attribute of the img tag. Instead, it is dynamically added by a js
  # script. The src value of an img is stored in the variable `s`
  # within an immediately invoked function expression (IIFE) which
  # defines a variable `ii` whose value is the img id. This method
  # retrieves the value from the script using the img id and a regular
  # expression.
  def get_img_src(doc, el)
    unless doc.is_a?(Nokogiri::HTML4::Document)
      warn "Expected a Nokogiri::HTML4::Document but received #{doc.class}"
      return nil
    end

    unless el.is_a?(Nokogiri::XML::Element)
      warn "Expected a Nokogiri::XML::Element but received #{el.class}"
      return nil
    end

    img_el = el.css('img').first
    return nil if img_el.nil?

    img_id = img_el['id']
    return nil if img_id.nil?

    scripts = doc.css('script')
    matching_script = scripts.find { |script| script.content.include?(img_id) }
    return nil if matching_script.nil?

    regex = /\(function\(\)\{var s='([^']+)';var ii=\['#{img_id}'\];_setImagesSrc\(ii,s\);\}\)\(\);/
    match = matching_script.content.match(regex)
    return match[1] if match

    nil
  end
end

# Methods for type 1 carousel (the kind of carousel in
# `files/van-gogh-paintings.html`)
module CarouselTypeOne
  include CarouselSharedMethods

  def get_name(el)
    unless el.is_a?(Nokogiri::XML::Element)
      warn "Expected a Nokogiri::XML::Element but received #{el.class}"
      return nil
    end

    anchor_el = el.css('a').first
    if anchor_el.nil?
      warn 'Expected anchor element is nil'
      return nil
    end

    anchor_el['aria-label']
  end

  def get_date(el)
    unless el.is_a?(Nokogiri::XML::Element)
      warn "Expected a Nokogiri::XML::Element but received #{el.class}"
      return nil
    end

    date_el = el.css('a > div:nth-child(2) > div:nth-child(2)').first

    return date_el.text.strip == '' ? nil : date_el.text.strip if date_el

    nil
  end
end

# Methods for type 2 carousel (the kind of carousel in
# `files/leonardo-da-vinci.html`)
module CarouselTypeTwo
  include CarouselSharedMethods

  def get_name(el)
    unless el.is_a?(Nokogiri::XML::Element)
      warn "Expected a Nokogiri::XML::Element but received #{el.class}"
      return nil
    end

    anchor_el = el.css('a').first
    if anchor_el.nil?
      warn 'Expected anchor element is nil'
      return nil
    end

    anchor_el['title']
  end

  def get_date(el)
    unless el.is_a?(Nokogiri::XML::Element)
      warn "Expected a Nokogiri::XML::Element but received #{el.class}"
      return nil
    end

    date_el = el.css('a > div:nth-child(2) div:nth-child(2)').first

    return date_el.text.strip == '' ? nil : date_el.text.strip if date_el

    nil
  end
end

# Class for the elements of the array we are expected to produce
class Artwork
  attr_accessor :name, :extensions, :link, :image

  def initialize(name, extensions, link, image)
    @name = name
    @extensions = if extensions.is_a?(Array)
                    extensions
                  else
                    extensions.nil? ? [] : [extensions]
                  end
    @link = link
    @image = image
  end

  # Serialize the Artwork instance to a hash
  def to_hash
    hash = { 'name' => @name }
    hash['extensions'] = @extensions unless @extensions.empty?
    hash.merge!({ 'link' => @link, 'image' => @image }) # make sure `extensions` comes after `name`
    hash
  end

  def to_s
    extensions_str = @extensions.empty? ? 'none' : @extensions.join(', ')
    "Name: #{@name}, Extensions: #{extensions_str}, Link: #{@link}, Image: #{@image}"
  end
end

# Produce the array of artworks given a document
class ArtworkProcessor
  attr_reader :doc

  def initialize(doc)
    @doc = doc
  end

  def process
    container = find_artworks_container

    extend(container[:type] == '1' ? CarouselTypeOne : CarouselTypeTwo)

    process_artworks(container[:el])
  end

  private

  def find_artworks_container
    # Attempt to directly select the container element
    el = doc.at_css('g-scrolling-carousel > :first-child > :first-child')

    return nil unless el

    # Determine the type based on the presence of an <a> tag as the
    # first element of the first child
    type = el.at_css('> :first-child > a') ? '1' : '2'

    # Adjust the element to be returned based on the type.
    container_el = type == '1' ? el : el.element_children.first

    { el: container_el, type: type }
  end

  def process_artworks(container_el)
    unless container_el.is_a?(Nokogiri::XML::Element)
      warn "Expected a Nokogiri::XML::Element but received #{container_el.class}"
      return []
    end

    artworks = []
    container_el.element_children.each do |el|
      name = get_name(el)
      date = get_date(el)
      link = get_href(el)
      image = get_img_src(doc, el)
      artwork = Artwork.new(name, date, link, image)
      artworks.push(artwork)
    end
    artworks
  end
end
