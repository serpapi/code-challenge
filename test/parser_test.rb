require "json"
require "test_helper"

class ParserTest < Minitest::Test
  def test_parses_artworks_from_file
    html_path = File.expand_path("../files/van-gogh-paintings.html", __dir__)
    text = File.read(html_path)

    json_path = File.expand_path("../files/expected-array.json", __dir__)
    json = JSON.parse(File.read(json_path))

    parser = Parser.new(text)
    assert_equal json["artworks"], parser.parse
  end
end
