describe GoogleParser do
  let(:file_path) { "file://#{File.expand_path('spec/fixtures/van-gogh-paintings.html')}" }
  let(:google_parser) { GoogleParser.new(file_path) }
  let(:node_parser_class) { NodeParser }

  describe '#parse' do
    let(:node_parser_object) { double(parse_node: true) }
    subject(:result) { google_parser.parse }

    before do
      allow(google_parser).to receive(:all_nodes).and_call_original
      allow(node_parser_class).to receive(:new).and_return(node_parser_object)
    end

    it 'calls NodeParser to parse node data' do
      subject
      expect(node_parser_class).to have_received(:new).exactly(51).times
    end

    it 'returns a hash' do
      expect(result).to be_a(Hash)
      expect(result[:artworks]).to be_an(Array)
    end
  end
end
