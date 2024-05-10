class CarouselParser
    attr_accessor :parsed
    
    def initialize(src)
        path = File.expand_path("../files/#{src}", File.dirname(__FILE__))
        @text = File.read(path)
        @parsed = []
    end

    def parse
        # get all carousel card blobs
        carousel = @text[/<div class="klbar">.*?<g-scrolling-carousel.*?>(.*?)<\/g-scrolling-carousel>/m]
        cards = carousel.scan(/<div.*?class="MiPcId klitem-tr.*?<\/a><\/div>/m)
        
        # pull out properties
        cards.each do |blob|
            href = blob[/\shref="(.*?)"\s/, 1]
            name = blob[/\stitle="(.*?)(\s\(\d+\))?"\s/, 1]
            date = blob[/klmeta">(.*?)<\/div>/, 1]
            image = blob[/id="kximg\d+"\s*?src="(.*?)"\s/, 1] # nil if no match, as expected
            @parsed.push({
                "name" => name,
                "link" => "https://www.google.com#{href}",
                "image" => image
            })
            if date
                @parsed[-1]["extensions"] = [ date ]
            end
        end
    end

end
