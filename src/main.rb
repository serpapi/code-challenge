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

        # image src replacement
        image_src_lookup = {}
        replacement_scripts = @text[/google\.iir\=google\.iir(.*?)<\/script>/].split(/var s='/)
        # create an id from div to base64 blob lookup
        replacement_scripts.each do |blob|
            base64 = /^(.*?)';var ii=\['(.*?)'\]/.match(blob)
            image_src_lookup[base64[2]] = base64[1] if base64
        end
        
        # pull out properties
        cards.each do |blob|
            href = blob[/\shref="(.*?)"\s/, 1]
            name = blob[/\stitle="(.*?)(\s\(\d+\))?"\s/, 1]
            date = blob[/klmeta">(.*?)<\/div>/, 1]
            image = /id="(kximg\d+)"\s*?src=".*?"\s/.match(blob) # nil if no match on src, as expected
            @parsed.push({
                "name" => name,
                "link" => "https://www.google.com#{href}",
                "image" => image
            })
            if date
                @parsed[-1]["extensions"] = [ date ]
            end
            if image
                # use the id from the image div to get the blob
                parsed[-1]["image"] = image_src_lookup[image[1]]
            end
        end
    end

end
