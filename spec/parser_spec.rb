require "json"
require "serpapi_challenge/parser"

RSpec.describe SerpapiChallenge::Parser do
  let(:parser) { described_class.new }

  it "parses the Van Gogh page into the expected structure" do
    input = File.expand_path("../files/van-gogh-paintings.html", __dir__)
    skip "Fixture not present" unless File.exist?(input)

    result = parser.parse_file(input)
    expect(result).to be_a(Hash)
    expect(result["artworks"]).to be_an(Array)
    expect(result["artworks"].length).to be > 0

    first = result["artworks"].first
    expect(first.keys.sort).to eq(%w[extensions image link name].sort)
    expect(first["name"]).to be_a(String)
    expect(first["link"]).to start_with("http")
    expect(first["extensions"]).to be_a(Array)
  end

  it "keeps only embedded (data URL) thumbnails" do
    input = File.expand_path("../files/van-gogh-paintings.html", __dir__)
    skip "Fixture not present" unless File.exist?(input)

    result = parser.parse_file(input)
    images = result["artworks"].map { |h| h["image"] }.compact
    expect(images.all? { |src| src.start_with?("data:image/") }).to be(true)
  end

  context "additional fixtures" do
    Dir[File.expand_path("fixtures/*.html", __dir__)].sort.each do |fixture|
      it "parses #{File.basename(fixture)}" do
        html = File.read(fixture, encoding: "UTF-8")
        result = parser.parse_html(html)
        expect(result["artworks"]).to be_an(Array)
        expect(result["artworks"].length).to be > 0
      end
    end

    it "skips if none added" do
      fixtures = Dir[File.expand_path("fixtures/*.html", __dir__)]
      skip "Add 2 similar SERP pages to spec/fixtures to run robustness tests" if fixtures.empty?
    end
  end
end
