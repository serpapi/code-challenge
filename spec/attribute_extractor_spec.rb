require 'rspec'
require 'json'
require_relative '../app/attribute_extractor'

RSpec.describe AttributeExtractor do
    context "with Van Gogh HTML" do
        let(:html_file) do
            File.open(File.expand_path('../../files/van-gogh-paintings.html', __FILE__))
        end
        let(:expected_array) do
            file_path = File.expand_path('../../files/expected-array.json', __FILE__)
            JSON.parse(File.read(file_path), symbolize_names: true)
        end

        it "finds the files and intiates the extractor" do
            expect(html_file).to be_truthy
            expect(expected_array).to be_truthy
            
            extractor = AttributeExtractor.new(html_file: html_file)
            expect(extractor).to be_truthy
        end
        it "provides a serialized attributes_hash for cards" do
            extractor = AttributeExtractor.new(html_file: html_file)
            json_of_artworks = extractor.get_artworks_attributes_hash
            expect(json_of_artworks.count).to eq((expected_array.first[1].count))
        end
    end
end
