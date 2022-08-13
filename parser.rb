require 'nokogiri'
require 'json'
require 'watir'
require 'uri'

class Parser
    def parse_old(file_path, extension_class)

        doc = get_parsed_html(file_path)
    
        cards = doc.css('a[aria-setsize]')
    
        results = [];
    
        cards.each do |val|
            extensions = []
            title = val.attr('aria-label')
    
            link = 'https://www.google.com' + val.attr('href')
    
            
            if extension_class == '.ellip.klmeta'
                extensions = val.css("#{extension_class}").map {|val| val.content}
            else 
                extension_html = val.css(".#{extension_class}")    
                extensions.push extension_html.last.content if !extension_html.last.nil?
            end
            
            img_src =  val.css('img').attr('src')
            
            img = img_src.nil? ? 'null' : img_src.value
    
            results.push({
                name: title,
                link: link,
                extensions: extensions,
                image: img
            })
        end
    
        results
    end
    
    def parse_new(file_path)
        doc = get_parsed_html(file_path)
    
        cards = doc.css('.iY0Hed')
        results = []
    
        cards.each do |val|
            title = val.css('.NJU16b').text
            link = val.css('a')[0].attr('href')
            
            img_src =  val.css('img').first.attr('src')
            img = (img_src.nil?) || !(img_src.include? "data:") ? 'null' : img_src
    
            results.push({
                name: title,
                link: link,
                image: img
            })
    
        end
    
        results
    end
    
    def get_parsed_html(url)
    
        b = Watir::Browser.new :chrome, headless: true

        b.goto url

        if URI.parse(url).kind_of?(URI::HTTP)
            right_button = b.elements(tag_name: "g-right-button").first

            for value in 1..5 do
                right_button.click
            end
        end
    
        Nokogiri::HTML(b.html)
    end
    
    def write_json_file(name, data)
        File.write("files/#{name}.json", JSON.pretty_generate(data))
    end
end


parser = Parser.new

van_gogh_file = "file://#{File.expand_path('files/van-gogh-paintings.html')}"
van_gogh_paintings = parser.parse_old(van_gogh_file, 'FozYP')
parser.write_json_file('van-gogh-paintings', van_gogh_paintings)

matthew_url = "https://www.google.com/search?q=matthew+mcconaughey+movies"
matthew_movies = parser.parse_old(matthew_url, 'FozYP')
parser.write_json_file('matthew-mcconaughey-movies', matthew_movies)

premier_file = "file://#{File.expand_path('files/premier-league-teams.html')}"
premier_teams = parser.parse_old(premier_file, 'FozYP')
parser.write_json_file('premier-league-teams', premier_teams)

# matt_damon_file = "file://#{File.expand_path('files/matt-damon-movies.mht')}"
# # matt_movies = parser.parse_new(matt_damon_file)
# # parser.write_json_file(matt_damon_file, matt_movies, '.mht')