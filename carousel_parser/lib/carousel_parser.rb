require "carousel_parser/version"
require "nokogiri"

module CarouselParser
  class Error < StandardError; end

  @carousel_css = "g-scrolling-carousel a[class^='klitem'], a[class*=' klitem']"
  @google_main_url = 'https://www.google.com/'

  def self.extract_name(element)
    return element.search(".kltat").text
  end

  def self.extract_extensions(element)
    return element.search(".klmeta").map {|elem| elem.text}.compact
  end

  def self.extract_link(element)
    return URI.join(@google_main_url, element.attribute("href").text).to_s
  end

  def self.extract_image(element)
    img_element = element.search("img")
    image_attributes = %w[
      data-src
      src
    ].each do |image_attr|
      if img_element.attribute(image_attr)
        return img_element.attribute(image_attr).text
      end
    end
  end

  def self.node_to_object(element)
    return {
        :name => self.extract_name(element),
        :extensions => self.extract_extensions(element),
        :link => self.extract_link(element),
        :image => self.extract_image(element),
    }
  end

  def self.get_carousel_objects(html)
    doc = Nokogiri::HTML(html)
    carousel_nodes = doc.search(@carousel_css)

    objects = []
    carousel_nodes.each do |node_element|
      objects.push(self.node_to_object(node_element))
    end

    return objects
  end
end
