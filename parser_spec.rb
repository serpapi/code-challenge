require_relative './parser'

RSpec.describe Parser do
  let(:parser) { Parser.new }

  context '#carousel' do
    it 'returns a valid nokogiri-parsed document' do
      expect(parser.carousel).to be_a Nokogiri::XML::NodeSet
    end
  end
  context '#extract_metadata' do
    it 'returns a list of 51 paintings by default' do
      expect(parser.extract_metadata.size).to eq 51
    end
    it 'includes the painting Starry Night by default' do
      expect(parser.extract_metadata
               .any? { |item| item.name == "The Starry Night" }).to be true
    end
  end
  context '#result' do
    it 'returns valid JSON' do
      expect { JSON.parse(parser.result) }.to_not raise_error
    end
    context 'returns an array of JSON objects that contains the keys' do
      it '"name"' do
        expect(JSON.parse(parser.result)).to all(have_key("name"))
      end
      it '"extensions" (which is an array)' do
        expect(JSON.parse(parser.result)).to all have_key("extensions")
        expect(JSON.parse(parser.result).all? { |item| item.dig("extensions").class == Array }).to be true
      end
      it '"link"' do
        expect(JSON.parse(parser.result)).to all(have_key("link"))
      end
      it '"image"' do
        expect(JSON.parse(parser.result)).to all(have_key("image"))
      end
    end
  end
end
