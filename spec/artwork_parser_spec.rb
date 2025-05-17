require "rspec"
require "json"
require_relative "../lib/artwork_parser"

RSpec.describe ArtworkParser do
  # Define the list of fixture base names to test
  %w[
    jacques-louis-david
    picasso
    van-gogh
  ].each do |artist|
    # Create a separate context for each artist to keep tests organized
    context "#{artist.gsub('-', ' ').capitalize} paintings fixture" do
      # Path to the HTML fixture for this artist
      let(:html_path)     { File.expand_path("fixtures/#{artist}-paintings.html", __dir__) }
      # Path to the expected output JSON fixture for this artist
      let(:json_path)     { File.expand_path("fixtures/#{artist}-expected-array.json", __dir__) }
      # Read the HTML content from the fixture file
      let(:html)          { File.read(html_path) }
      # Parse the expected artwork array from the JSON fixture
      let(:expected_array){ JSON.parse(File.read(json_path)) }

      # Instantiate the parser
      subject { described_class.new(html) }

      describe "#parse" do
        it "extracts exactly the expected artwork array for #{artist}" do
          # Compare the parser's output against our expected array
          expect(subject.parse).to eq(expected_array)
        end
      end
    end
  end
end
