require 'nokogiri'
require 'open-uri'
require 'base64'
require 'json'

# Test files
$doc_van_gogh = File.open("van-gogh-paintings.html") {|f| Nokogiri::HTML5(f)}
$doc_football_players = File.open("top-football-players.html") {|f| Nokogiri::HTML5(f)}
$doc_nba_players = File.open("top-nba-players.html") {|f| Nokogiri::HTML5(f)}


def create_hash(name, extensions, link, image)

    show_extensions = true

    if extensions == "Null"
        show_extensions = false
    end

    return {
            "name" => name,
            # If extensions does not exist (=="Null"), return {}
            **(show_extensions ? {"extensions" => [extensions]}: {}),
            "link" => link,
            "image" => image
    }
end

def get_base_64(img_src)
    if img_src.class != NilClass
        base_64_part = img_src.text.partition('base64,').last
        decoded_b64_part = Base64.decode64(base_64_part)
        new_str = img_src.text.partition('base64,').first + 'base64,' + decoded_b64_part
    end
    return new_str
end

def run_crawl(doc)

    final_arr = []

    # Get nodeList of a tags
    a_tags = doc.css("g-scrolling-carousel")[0].css("a")
    
    # Gather relevant data and create final array
    a_tags.each do |a_tag|

        # Get names and links
        name = a_tag.attr("aria-label")
        link = a_tag.attr("href")
        
        # Format of html differs between van gogh file and other html files. 
        # Simply, the extension is in a different place for other html files (.cp7THd instead of .klmeta)
        # This also checks whether extension is blank
        if a_tag.at_css(".cp7THd")
            extensions = a_tag.css(".cp7THd").text
        elsif a_tag.at_css(".klmeta")
            extensions = a_tag.css(".klmeta").text
        else
            extensions = "Null"
        end

        # Get image, need to decode base64
        image = a_tag.css("img").attr('src')
        #full_image_src = get_base_64(image).encode("UTF-8", invalid: :replace, undef: :replace)

        final_arr.push(create_hash(name, extensions, link, image))

    end

    # Make json file
    json_str = JSON.pretty_generate(final_arr)
    File.open("expected-array.json", 'w') { |file| file.write(json_str) }

end

# Can uncomment to test with other data

run_crawl($doc_van_gogh)
#run_crawl($doc_football_players)
#run_crawl($doc_nba_players)
