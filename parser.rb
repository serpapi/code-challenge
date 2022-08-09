require 'nokogiri'
require 'json'
require 'watir'

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
    
    def get_parsed_html(file_path)
        full_file_path = File.expand_path(file_path)
    
        b = Watir::Browser.new :chrome, headless: true
        b.goto "file://#{full_file_path}"
    
        Nokogiri::HTML(b.html)
    end
    
    def write_json_file(file_path, data, extension)
        File.write("files/#{File.basename(file_path, "#{extension}")}.json", JSON.pretty_generate(data))
    end
end


parser = Parser.new

van_gogh_file = 'files/van-gogh-paintings.html'
van_gogh_paintings = parser.parse_old(van_gogh_file, '.ellip.klmeta')
parser.write_json_file(van_gogh_file, van_gogh_paintings, '.html')

matthew_file = 'files/matthew-mcconaughey-movies.html'
matthew_movies = parser.parse_old(matthew_file, 'FozYP')
parser.write_json_file(matthew_file, matthew_movies, '.html')

premier_file = 'files/premier-league-teams.html'
premier_teams = parser.parse_old(premier_file, 'FozYP')
parser.write_json_file(premier_file, premier_teams, '.html')

matt_damon_file = 'files/matt-damon-movies.mht'
matt_movies = parser.parse_new(matt_damon_file)
parser.write_json_file(matt_damon_file, matt_movies, '.mht')