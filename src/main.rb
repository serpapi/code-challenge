class CarouselParser
    attr_accessor :parsed
    
    def initialize(src)
        @src = src
        # Example expected object which should pass all tests
        @parsed = [
            {
                "name" => "The Starry Night",
                "extensions" => [ "1889" ],
                "link" => "https://www.google.com/search?...",
                "image" => "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/..."
            },
            {
                "name" => "The Starry Night",
                "extensions" => [ "1889" ],
                "link" => "https://www.google.com/search?...",
                "image" => nil
            }
        ]
    end

    def parse
    end

end
