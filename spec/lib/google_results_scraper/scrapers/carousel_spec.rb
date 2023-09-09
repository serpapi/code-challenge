describe GoogleResultsScraper::Scraper do
  describe '#extract_carousels' do
    ['jrr-tokien', 'van-gogh', 'red-hot-chili-peppers', 'van-gogh-original'].each do |page|
      describe "with #{page} page" do
        let(:input) { File.read(File.join('spec', 'fixtures', 'carousel', "#{page}.html")) }
        subject { GoogleResultsScraper::Scraper.new(input).extract_carousels }

        it 'respects the expected format' do
          is_expected.to be_a(Array)
          is_expected.to all have_key(:title).and have_key(:items)
          is_expected.to all satisfy { |carousel|
            carousel[:items].all? do |item|
              item.is_a?(Hash) &&
                item.key?(:name) &&
                item[:name].is_a?(String) &&
                item.key?(:link) &&
                item[:link].is_a?(String) &&
                item.key?(:image) &&
                (item[:image].is_a?(String) || item[:image].is_a?(NilClass)) &&
                item.key?(:extensions) &&
                item[:extensions].is_a?(Array) &&
                item[:extensions].all? { |extension| extension.is_a?(String) }
            end
          }
        end

        it "extracts the expected data" do
          expected_output = JSON.parse(File.read(File.join('spec', 'fixtures', 'carousel', "#{page}.json")), symbolize_names: true)
          is_expected.to eq(expected_output)
        end
      end
    end
  end
end
