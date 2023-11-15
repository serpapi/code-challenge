class Artwork
  attr_reader :extensions
  attr_reader :image
  attr_reader :link
  attr_reader :name

  GOOGLE_URL = "https://www.google.com".freeze

  def initialize extensions: nil, image: nil, link: nil, name: nil
    @extensions = extensions
    @image = image
    @link = link
    @name = name
  end

  def as_hash
    h = {
      image: image,
      link: link,
      name: name
    }
    h[:extensions] = extensions unless extensions && extensions.empty?
    h
  end

  def self.from_link_element link_element, script
    link = GOOGLE_URL + link_element["href"]

    text = link_element.content
    extensions = /(\d+)/.match(text)&.captures

    # Remove date and handle nil extensions
    name = text.split(extensions&.first).join(" ")
    name = name.gsub "\n", ""
    name = name.split.reject(&:empty?).join " "

    id = link_element.at("img")["id"]

    image = image_data_from_id id, script

    Artwork.new extensions: extensions, image: image, link: link, name: name
  end

  def self.image_data_from_id id, script
    return nil if id.nil?

    func = script.split("{").select { |el| el&.include? id }.first
    return nil unless func

    data = /"(data:.*)"/.match func
    data&.captures&.first&.gsub "\\", ""
  end
end
