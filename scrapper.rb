require "nokogiri"
require 'fileutils'
require "json"

def get_full_image(html, image_id)
    return html.scan(/var s='([^']+)';var ii=\['#{image_id}'\]/)&.first&.first&.gsub(/\\/, '')
end

def parse_carousel(file)
    carousel_class = "a[class*='klitem']"

    doc = Nokogiri::HTML(file)

    list = []

    doc.css(carousel_class).each do |node|
        matches = node["title"].match(/\((.*)\)/)

        list.push({
            name: node["aria-label"],
            extensions: matches ? [matches[1]] : [],
            link: node["href"] ? "https://google.com" + node["href"] : "",
            image: get_full_image(file, node.css("img").first["id"])
        })
    end

    json = JSON.pretty_generate({
        artworks: list
    })

    unless File.directory?("output")
        FileUtils.mkdir_p("output")
    end

    File.open("./output/" + ARGV[0] + "_output.json", "w") {|file| file.write(json)}
end

if ARGV[0] == "van_gogh_paintings"
    file = File.read("./files/van-gogh-paintings.html")
elsif ARGV[0] == "avengers_endgame_cast"
    file = File.read("./files/avengers-endgame-cast.html")
elsif ARGV[0] == "bmw_cars"
    file = File.read("./files/bmw-cars.html")
elsif ARGV[0] == "harry_potter_cast"
    file = File.read("./files/harry-potter-cast.html")
else
    puts "\nOops!...Please provide valid option!"
    puts "\nPossible command are:"
    puts "\truby scrapper.rb \"van_gogh_paintings\""
    puts "\truby scrapper.rb \"avengers_endgame_cast\""
    puts "\truby scrapper.rb \"bmw_cars\""
    puts "\truby scrapper.rb \"harry_potter_cast\""
    exit!
end

parse_carousel(file)