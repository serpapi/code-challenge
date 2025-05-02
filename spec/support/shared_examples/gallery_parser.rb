# frozen_string_literal: true

RSpec.shared_examples 'a gallery parser' do |fixture_name|
  let(:parser) { described_class.new(page) }

  describe '#parse' do
    let(:file_path) do
      File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'fixtures/pages', "#{fixture_name}.html"))
    end
    let(:browser) { Ferrum::Browser.new(headless: true) }
    let(:page) { browser.create_page }

    before do
      page.go_to("file://#{file_path}")
    end

    after do
      browser.quit
    end

    let(:expected_json) do
      File.read(File.join(File.dirname(__FILE__), '..', '..', 'fixtures/expected', "#{fixture_name}.json"))
    end
    let(:expected_json_data) { JSON.parse(expected_json, symbolize_names: true) }

    subject { parser.as_json }

    it 'returns expected JSON' do
      expect(subject).to eq(expected_json_data)
    end
  end
end
