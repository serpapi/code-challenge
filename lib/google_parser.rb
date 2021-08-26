require 'nokogiri'
require 'byebug'
require 'json'

class GoogleParser
  def initialize; end

  def call
    page = File.open('./files/van-gogh-paintings.html')
    html = Nokogiri::HTML(page)
    parsed_page = html.css('div.EDblX.DAVP1')
    data = parsed_page.css('div.MiPcId.klitem-tr.mlo-c a').map do |painting|
            extracted_data(painting)
          end

    return JSON.pretty_generate({ artworks: data })
  end

  private

  def extracted_data(painting)
    {
      name: get_name(painting),
      extensions: [get_date(painting)],
      link: get_link(painting),
      image: get_image(painting)
    }
  end

  def get_link(painting)
    "https://www.google.com#{painting.attributes["href"]&.value}"
  end

  def get_image(painting)
    painting.at_css('g-img img').attributes["data-key"]&.value
  end

  def get_name(painting)
    span = painting.css('.kltat span')
    if span.count > 1
      span.first.text + span.last.text
    else
      span.first.text
    end
  end

  def get_date(painting)
    painting.at_css('.ellip.klmeta')&.text
  end
end


puts GoogleParser.new.call
