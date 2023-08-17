# frozen_string_literal: true

RSpec.describe Parser::Google::Carousel do
  let(:fixture) do
    fixture_name
      .then { |path| File.expand_path("./fixtures/google/carousel/#{path}") }
      .then { |path| Fixture.load!(path) }
  end

  let(:page_api) { PageApi::Nokolexbor }
  let(:verifier) { Parser::Verifier.new(parser.parse, fixture.expected) }

  let(:parser) { described_class.new(page_api:, data: fixture.data) }

  describe 'Artwork carousel type' do
    describe 'variant1' do
      let(:fixture_name) { 'variant1' }

      it 'should parse google results' do
        expect(parser.parse).to be_instance_of(Parser::Response)
      end

      it 'should be verified using expected output' do
        expect(verifier.valid?).to be(true)
      end
    end

    describe 'variant2' do
      let(:fixture_name) { 'variant2' }

      it 'should parse google results' do
        expect(parser.parse).to be_instance_of(Parser::Response)
      end

      it 'should be verified using expected output' do
        expect(verifier.valid?).to be(true)
      end
    end
  end
end
