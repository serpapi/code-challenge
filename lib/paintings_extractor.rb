require 'nokogiri'

class PaintingsExtractor
  def initialize(html)
    @doc = Nokogiri::HTML(html)
  end


  def extract_paintings
    paintings = []

    @doc.css('a.klitem').each do |painting|
      paintings << {}.tap do |h|
        h[:image] = painting.css('g-img > img').attr('src')
        h[:link] = extract_google_href(painting)
        h[:name] = painting.attr('aria-label')
        h[:extensions] = [painting.css('div.klmeta').text]
      end
    end

    paintings
  end

  private

  def extract_google_href(painting)
    slug = painting.attr('href')
    return nil if slug.nil? || slug.strip.empty?

    "https://www.google.com#{slug}"
  end
end