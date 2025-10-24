require "nokogiri"

class Scraper
  BASE_URL = 'https://www.google.com'

  def self.scrape(html)
    { "artwork" => parse_data(html) }
  end

  private

  def self.parse_data(html)
    data = Nokogiri::HTML(html)
    script_images = extract_script_images(html)

    results = data.css('.iELo6')
    results.map.with_index do |result, index|
      image_element = result.at_css('.taFZJe')
      image_src = image_element['data-src'] || script_images[index] || image_element['src']

      extensions = [result.at_css('.cxzHyb').text]
      extensions = extensions[0] == '' ? nil : extensions

      {
        name: result.at_css('.pgNMRc').text,
        extensions: extensions,
        link: "#{BASE_URL}#{result.at_css('a')['href']}",
        image: image_src
      }.compact
    end
  end

  def self.extract_script_images(html)
    html.scan(/var s='(data:image[^']+)'/).flatten
  end
end