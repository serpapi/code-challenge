describe MusicAlbumsGalleryParser do
  let(:parser) { described_class.new }

  describe '#parse' do
    let(:file_path) { File.expand_path(File.join(File.dirname(__FILE__), '..', 'fixtures/pages', 'taylor-swift-albums.html')) }
    let(:browser) { Ferrum::Browser.new(headless: true) }
    let(:page) { browser.create_page }

    before do
      page.go_to("file://#{file_path}")
    end

    let(:expected_json) { File.read(File.join(File.dirname(__FILE__), '..', 'fixtures/expected/taylor-swift-albums.json')) }
    let(:expected_json_data) { JSON.parse(expected_json, symbolize_names: true) }

    subject { parser.parse(page) }

    it 'returns expected JSON' do
      expect(subject).to eq(expected_json_data)
    end
  end
end
