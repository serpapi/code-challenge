require "minitest/autorun"
require "json"
require_relative "../lib/google_carousel_parser"

class GoogleCarouselParserTest < Minitest::Test
  def setup
    files_dir = File.expand_path("../../files", __FILE__)
    @html_van_gogh = File.read(File.join(files_dir, "van-gogh-paintings.html"))
    @html_picasso = File.read(File.join(files_dir, "picasso-paintings.html"))
    @html_empty = File.read(File.join(files_dir, "empty.html"))
    @expected_van_gogh = JSON.parse(
      File.read(File.join(files_dir, "expected-array.json"))
    )
  end

  def test_parses_number_of_artworks_from_van_gogh
    result = GoogleCarouselParser.new(@html_van_gogh).call

    assert_equal(
      @expected_van_gogh["artworks"].size,
      result["artworks"].size,
      "Parsed result did not match expected output"
    )
  end

  def test_parses_artwork_names_from_van_gogh
    result = GoogleCarouselParser.new(@html_van_gogh).call

    assert_equal(
      @expected_van_gogh["artworks"].map { |a| a["name"] },
      result["artworks"].map { |a| a["name"] },
      "Names did not match expected output"
    )
  end

  def test_parses_artwork_extensions_from_van_gogh
    result = GoogleCarouselParser.new(@html_van_gogh).call

    assert_equal(
      @expected_van_gogh["artworks"].map { |a| a["extensions"] },
      result["artworks"].map { |a| a["extensions"] },
      "Extensions did not match expected output"
    )
  end

  def test_parses_artwork_links_from_van_gogh
    result = GoogleCarouselParser.new(@html_van_gogh).call

    assert_equal(
      @expected_van_gogh["artworks"].map { |a| a["link"] },
      result["artworks"].map { |a| a["link"] },
      "Link did not match expected output"
    )
  end

  def test_parses_artwork_images_from_van_gogh
    result = GoogleCarouselParser.new(@html_van_gogh).call

    assert_equal(
      @expected_van_gogh["artworks"].map { |a| a["image"] },
      result["artworks"].map { |a| a["image"] },
      "Image did not match expected output"
    )
  end

  def test_returns_empty_array_from_empty_html
    mock_logger = Minitest::Mock.new
    mock_logger.expect(:warn, nil, ["[GoogleCarouselParser] No hidden images found in the HTML."])
    mock_logger.expect(:warn, nil, ["[GoogleCarouselParser] No artwork links found in the HTML."])

    result = GoogleCarouselParser.new(@html_empty, mock_logger).call

    assert_equal([], result["artworks"], "Empty HTML should return empty artworks array")
    assert_equal({"artworks" => []}, result, "Empty HTML should return expected structure")
    assert_mock mock_logger
  end

  def test_parses_number_of_artworks_from_picasso
    result = GoogleCarouselParser.new(@html_picasso).call

    assert_equal(
      45,
      result["artworks"].size,
      "Parsed result did not match expected output"
    )
  end
end
