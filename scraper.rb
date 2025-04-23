require 'nokogiri'

# I don't have experience with ruby so i'll put the references as i go along
# i will write as I would if I was to do it in JS

# Refs
# Finding out about unless statements: https://www.geeksforgeeks.org/ruby-unless-statement-and-unless-modifier/
# Finding about the safe navigation operator https://mitrev.net/ruby/2015/11/13/the-operator-in-ruby/
# has the exact same functionality as ?. in JS so i grasped this quickly


# This is my initial set up when thinking about the problem.
# Getting the needed class names by putting the html file in a browser
# and putting them in an object
class PaintingScraper
  def initialize(html_path)
    @html = extract_html_from_file(html_path)

    @location_url = "https://www.google.com"

    @class_names = {
      carousel: 'Cz5hV',  # parent <div> containing the paintings
      paintings: 'iELo6', # paintings <div> within carousel
      image: 'taFZJe',    # img inside <a> tag
      info: 'KHK6lb',     # div inside <a> tag containing painting info
      name: 'pgNMRc',     # name of painting inside info
      date: 'cxzHyb',     # age of painting inside info
    }
  end

  def extract_html_from_file(html_path)
    file = File.read(html_path)
    html = Nokogiri::HTML(file)
    return html
  end

  def parse_html()
    carousel = @html.at_css('.' + @class_names[:carousel])
  
    paintings = { artworks: [] }
  
    carousel.children.each do |child|
      next unless child.element?
      next unless child['class'] == @class_names[:paintings]
  
      info = child.at_css('a')
      next unless info
  
      painting_link = info['href'] || "Link not found"
  
      painting_image = info.at_css('.' + @class_names[:image])
      image_src = painting_image&.[]('src') || "Image not found"
  
      painting_info = info.at_css('.' + @class_names[:info])
      painting_name = painting_info&.at_css('.' + @class_names[:name])&.text.strip || "Name not found"
      painting_age = painting_info&.at_css('.' + @class_names[:date])&.text.strip || "Date not found"
  
      paintings[:artworks] << {
        link: @location_url + painting_link,
        image: image_src,
        name: painting_name,
        extensions: [painting_age]
      }
    end

    return paintings
  end
  
end