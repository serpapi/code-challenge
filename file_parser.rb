# frozen_string_literal: true

# file_parse.rb
class FileParser
  def initialize(content)
    @page = Nokogiri::HTML(content)
  end

  def parse
    all_elements = @page.css('div.MiPcId.klitem-tr.mlo-c')

    artworks = []
    all_elements.each do |item|
      name = item.css('a').first.attributes['aria-label']&.value
      extention = item.css('.ellip.klmeta').text
      search_query = item.css('a').first.attributes['href']&.value
      link = URI.join('https://www.google.com', search_query).to_s
      image = item.css('.klzc > .klic > g-img > img')
                  .first.attributes['src']&.value

      output = {
        name: name,
        link: link,
        image: image
      }.merge(extention.empty? ? {} : { extensions: [extention] })

      artworks.push(output)
    end
    { 'artworks': artworks }
  end
end
