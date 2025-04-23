require 'nokogiri'

# This is my initial set up when thinking about the problem.
# Getting the needed class names by putting the html file in a browser
# and putting them in an object
class PaintingScraper
  def initialize(html_path)
    @html = extract_html_from_file(html_path)

    @class_names = {
      carousel: '.Cz5hV',  # parent div containing the paintings
      paintings: '.iELo6', # paintings div within carousel
      image: '.taFZJe',    # img inside <a> tag
      info: '.KHK6lb',     # div inside <a> tag containing painting info
      name: '.pgNMRc',      # name of painting inside info
      date: '.cxzHyb',      # age of painting inside info
    }
  end

  def extract_html_from_file(html_path)
    file = File.read(html_path)
    html = Nokogiri::HTML(file)
    return html
  end

  def parse_html()
    carousel = @html.at_css(@class_names[:carousel])

    carousel.children.each do |child|
      puts child
    end
  end
end