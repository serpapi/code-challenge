require 'nokogiri'

class PaintingScraper
  def self.extract_from_file(html_path)
    html = File.read(html_path)
    doc = Nokogiri::HTML(html)

    puts doc
  end
end