require "rspec"
require "../main.rb"

RSpec.describe CarouselParser do
    before(:context) do
        parser = CarouselParser.new("../../files/van-gogh-paintings.html")
        parser.parse
        @parsed = parser.parsed
    end

    # Tests
    # ...
end