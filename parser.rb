require 'nokogiri'
require 'open-uri'

class Parser


  def initialize(path,css_patterns)
    @doc = Nokogiri::HTML(URI.open(path))
    @css_patterns = css_patterns
    @results = []
    parse()
  end

  def results
    @results
  end

  def find_css_and_map_to_objects(css_pattern)
    @doc.css(css_pattern).to_a.map do |element|
      map_to_object(element)
    end.compact
  end
  
  def map_to_object(element)
    return unless name = element.xpath('@aria-label').first&.value || element.xpath('@title').first&.value
    extensions = if element.at_css('.wwLdc')
                   element.css('.wwLdc')
                 else
                   element.css('.klmeta')
                 end              
    {
      "name" => name&.encode("iso-8859-1").force_encoding("utf-8").chomp,
      "extensions" => extensions.to_a.map { |extension| extension.text&.chomp&.strip},
      "link" => "https://www.google.com#{element.xpath('@href').first&.value&.chomp}",
      "image" => find_image_data(element.at_css('img')&.xpath('@id').first&.value)
    }.reject{|key, value| value&.empty?}
  end

  def find_image_data(id)
    return if id.nil?
    img = @doc.to_html.scan(/var s='([^']+)';var ii=\['#{id}'\]/)&.first&.first&.gsub(/\\/,'')
  end
  
  def parse()
    for pattern in @css_patterns
      parsed_elements_for_pattern = find_css_and_map_to_objects(pattern)
      @results.concat(parsed_elements_for_pattern)
    end
  end
  
end
