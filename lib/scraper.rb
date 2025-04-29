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

    @images_data = {} # script tags with nonce xmO6un4J9murPFDygFfaMA that have full image data
    @script_nonce = 'xmO6un4J9murPFDygFfaMA'
  end

  def extract_html_from_file(html_path)
    file = File.read(html_path)
    html = Nokogiri::HTML(file)
    return html
  end

  def init_image_data()
    scripts = @html.css("script[nonce='#{@script_nonce}']")

    scripts.each do |tag|
      next unless tag.content.include?("data:image")
      id = tag.content.match(/var ii=\['([^']*)'\]/)
      img_data = tag.content.match(/var s='(data:image\/jpeg;base64,[^']*)';/)

      next unless id && id[1]
      next unless img_data && img_data[1]

      img_data = img_data[1].gsub("\\x3d", "=")

      @images_data[id[1]] = img_data
    end
  end

  def parse_html()
    init_image_data()

    carousel = @html.at_css('.' + @class_names[:carousel])
    
    paintings = { artworks: [] }

    return paintings unless carousel
  
    carousel.children.each do |child|
      next unless child.element?
      next unless child['class'] == @class_names[:paintings]
  
      info = child.at_css('a')
      next unless info
  
      painting_link = info['href'] || "Link not found"
  
      painting_image = info.at_css('.' + @class_names[:image])

      # check data-src first
      image_src = painting_image&.[]('data-src')

      # check if it has default base64, then look for the actual
      # image data in the map generated from get_image_data()
      if (image_src.nil?) 
        image_src = painting_image&.[]('src')
        if (image_src == "data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==")
          image_id = painting_image&.[]('id')
          
          image_data = @images_data[image_id]
          next unless image_data
          
          image_src = image_data
        end
      end

      painting_info = info.at_css('.' + @class_names[:info])

      painting_name = painting_info&.at_css('.' + @class_names[:name])&.text&.strip
      painting_name = painting_name.empty? ? nil : painting_name

      painting_age = painting_info&.at_css('.' + @class_names[:date])&.text&.strip
      painting_age = painting_age.nil? || painting_age.empty? ? nil : painting_age

      painting_data = {
        name: painting_name,        # Or could use alt from <img> not sure which ones best
        link: @location_url + painting_link,
        image: image_src
      }
      if painting_age
        painting_data[:extensions] = [painting_age]
      end
      paintings[:artworks] << painting_data

    end
    return paintings
  end
  
end