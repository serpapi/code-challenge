require "json"
require "nokogiri"

require_relative "artwork"

class Page
  attr_accessor :html

  def initialize html
    @html = html
  end

  def artwork_section
    return @artwork_section if @artwork_section

    @artwork_section = html.at "div[data-attrid=\"kc:/visual_art/visual_artist:works\"]"
    @artwork_section ||= html.at "g-scrolling-carousel"
  end

  def image_src_script
    return @image_src_script if @image_src_script

    @image_src_script = ""

    html.search("script").each do |script|
      if script.content.include? "setImagesSrc"
        @image_src_script += script.content
      end
    end

    @image_src_script
  end

  def artworks
    return @artworks if @artworks


    links = artwork_section.search "a"
    @artworks = links.map { |link| Artwork.from_link_element link, image_src_script }
  end

  def as_json
    as_hash.to_json
  end

  def as_hash
    {
      artworks: artworks.map(&:as_hash)
    }
  end

  def self.from_file_path path
    file = File.read path
    html = Nokogiri::HTML file
    Page.new html
  end
end
