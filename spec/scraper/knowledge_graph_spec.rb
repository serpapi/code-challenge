require 'rspec'
require_relative '../../scraper/knowledge_graph'

describe KnowledgeGraph do
  subject(:knowledge_graph) { described_class.new(html) }

  shared_examples 'correct result structure' do
    it 'returns result with expected structure' do
      expect(result[:artworks]).to_not be_empty

      result[:artworks].each do |artwork|
        expect(artwork).to match(
          name: be_a(String),
          link: be_a(String),
          image: be_a(String).or(be_nil),
          extensions: be_an(Array)
        ).or(
          match(
            name: be_a(String),
            link: be_a(String),
            image: be_a(String).or(be_nil)
          )
        )
      end
    end
  end

  describe '#to_h' do
    subject(:result) { knowledge_graph.to_h }

    context 'when html contains old carousel type' do
      let(:html) { File.read('./files/van-gogh-paintings.html') }

      include_examples 'correct result structure'
    end

    context 'when html contains new carousel type' do
      let(:html) { File.read('./files/list-of-popes.html') }

      include_examples 'correct result structure'
    end

    context 'when html contains grid instead of carousel' do
      let(:html) { File.read('./files/rhcp-members.html') }

      include_examples 'correct result structure'
    end

    context 'when html contains grid instead of carousel' do
      let(:html) { File.read('./files/rhcp-members.html') }

      include_examples 'correct result structure'
    end

    context 'when html does not contain any type' do
      let(:html) do
        <<~HTML
          <!DOCTYPE html>
          <html lang = "en-US">
            <head>
              <meta charset = "utf-8">
              <title>My test page</title>
            </head>
            <body>
              <p>There's no gallery</p>
            </body>
          </html>
        HTML
      end

      it 'returns empty artworks' do
        expect(result[:artworks]).to be_empty
      end
    end
  end
end
