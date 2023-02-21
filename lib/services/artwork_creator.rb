require 'nokogiri'
require 'json'
require './lib/models/artwork'

class ArtworkCreator
  attr_reader :file, :from_path, :to_path

  def initialize(from_path, to_path)
    @from_path = from_path
    @to_path = to_path
    @file = Nokogiri::HTML5(File.read(from_path))
  end

  def to_json_file
    File.open(to_path, 'w') do |file|
      file.write(JSON.pretty_generate('artworks': artworks))
    end
  end

  private

  def artworks
    arts = []
    file.css('.klitem').each do |element|
      art = Artwork.new(
        name: name(element),
        extensions: extensions(element),
        link: link(element),
        image: image(element)
      ).to_h
      arts << art
    end
    arts
  end

  def name(element)
    element.attribute('aria-label')&.value
  end

  def extensions(element)
    es = element.css('.cp7THd').children.css('.FozYP') || element.css('.klmeta')
    es.map { |e| e.text.strip }
  end

  def link(element)
    link = element.attribute('href')&.value
    link.start_with?('https') ? link : "https://www.google.com#{link}"
  end

  def image(element)
    id = element.css('img').attribute('id')&.value
    images[id]
  end

  def images
    @images ||= {}
    return @images unless @images.empty?

    js = file.css('script').map(&:text).join
    ids = js.scan(/var ii=\['(\S+)'\];/)
    imgs = js.scan(%r{var s='(data:image/jpeg;base64,\S+)'}).flatten.each { |i| i.gsub!('\\', '') }

    @images = ids.flatten.zip(imgs).to_h
  end
end
