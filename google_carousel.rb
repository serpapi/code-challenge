require 'oga'

class GoogleCarousel

  def self.parse_html(raw_html)
    parsed_html = Oga.parse_html(raw_html)

    if parsed_html.at_css('g-scrolling-carousel.arDHIe a') # newer version
      carousel_html = parsed_html.css('g-scrolling-carousel.arDHIe a')
    else
      carousel_html = parsed_html.css('g-scrolling-carousel a')
    end

    carousel_html.to_a.map do |carausel_el|
      name =  carausel_el.get('aria-label') || carausel_el.get('title')
      next if name.nil?

      extensions = if carausel_el.at_css('.wwLdc') # newer version
        carausel_el.css('.wwLdc')
      else
        carausel_el.css('.klmeta')
      end

      {
        "name" => name&.chomp,
        "extensions" => extensions.to_a.map { |ext| ext.text&.chomp&.strip },
        "link" => "https://www.google.com#{carausel_el.get('href')&.chomp}",
        "image" => get_image_from_js(raw_html, carausel_el.at_css('img')&.get('id'))
      }.reject{|k, v| v&.empty? }
    end.compact
  end

  # the image is in the javascript and is thankfully keyed by an id we can get from the HTML.
  # capture the image string, and remove '\\' javascript encoding
  def self.get_image_from_js(raw_html, image_id)
    return if image_id.nil?
    raw_html.scan(/var s='([^']+)';var ii=\['#{image_id}'\]/)&.first&.first&.gsub(/\\/, '')
  end
end
