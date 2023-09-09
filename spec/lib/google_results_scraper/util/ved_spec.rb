describe GoogleResultsScraper::Util::Ved do
  let(:input_html) { File.read(File.join('spec', 'fixtures', 'ved', 'partial-with-ved-data.html')) }
  let(:input_node) { Nokogiri::HTML(input_html) }

  describe '.elements_with_type' do
    subject { GoogleResultsScraper::Util::Ved.elements_with_type(input_node, 27979) }

    it 'finds the nodes with [data-ved] that decodes to the given type number' do
      expect(subject.count).to eq(2)
      expect(subject.map { |node| node['id'] }).to eq(['tolkien-books', 'tolkien-movies'])
    end
  end

  describe '.find_element_with_type' do
    subject { GoogleResultsScraper::Util::Ved.find_element_with_type(input_node, 27979) }

    it 'finds the first node with [data-ved] that decodes to the given type number' do
      expect(subject['id']).to eq('tolkien-books')
    end
  end
end
