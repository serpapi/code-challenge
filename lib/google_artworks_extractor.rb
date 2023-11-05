require 'nokogiri'

# Extracts paintings from a Google search page
class GoogleArtworksExtractor
  def initialize(input)
    @html = Nokogiri::HTML(input)
  end

  def run
    results = artworks.map do |artwork|
      {
        name: name(artwork),
        link: link(artwork),
        image: image_src(artwork.css('img').attr('id').value)
      }.tap do |result|
        result[:extensions] = extensions(artwork) if extensions(artwork).any?
      end
    end

    { category => results }
  end

  private

  def artworks
    @html.css('a.klitem')
  end

  def name(node)
    node.css('.kltat').text
  end

  def extensions(node)
    node.css('.klmeta').map(&:text)
  end

  def link(node)
    "https://www.google.com#{node.attr('href')}"
  end

  def image_src(id)
    results = @html.text.match(/var s='(\S*)';var ii=\['#{id}'\]/)
    results[1].delete('\\') if results
  end

  def category
    @html.xpath('//span[@data-elabel]').last.text.downcase.to_sym
  end
end
