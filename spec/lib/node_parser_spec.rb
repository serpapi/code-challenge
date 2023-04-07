describe NodeParser do
  subject(:result) { node_parser.parse_node }
  let(:file_path) { "file://#{File.expand_path('spec/fixtures/sample.html')}" }
  let(:browser) do
    browser = Ferrum::Browser.new
    browser.go_to(file_path)
    browser
  end
  let(:node) { browser.at_css('div.MiPcId.klitem-tr.mlo-c') }
  let(:base_url) { 'https://foo.com' }
  let(:node_parser) { NodeParser.new(node, base_url) }
  let(:expected_keys) { [:name, :link, :image, :extensions] }
  let(:expected_values) do
    [
      "foo",
      "https://foo.com/bar",
      "https://an_image.com/",
      ["2023"]
    ]
  end

  describe '#parse_node' do
    it 'returns expected data' do
      expect(result).to be_a(Hash)
      expect(result.keys).to eq(expected_keys)
      expect(result.values).to eq(expected_values)
    end

    describe 'when html file is empty' do
      let(:file_path) { "file://#{File.expand_path('spec/fixtures/empty.html')}" }
      let(:expected_values) { [nil, nil, nil] }
      let(:expected_keys) { [:name, :link, :image] }

      it 'returns nil values' do
        expect(result.values).to eq(expected_values)
      end

      it 'does not include :extensions key in the result' do
        expect(result.keys).to eq(expected_keys)
      end
    end
  end
end
