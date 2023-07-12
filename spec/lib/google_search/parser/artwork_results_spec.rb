# frozen_string_literal: true

require 'google_search/parser/artwork_results'

RSpec.shared_examples 'google artwork parser' do |results_path|
  let(:file_io) { File.open(results_path) }
  let(:parser) { described_class.new(file_io) }

  let(:expected_attributes) do
    {
      name: a_kind_of(String),
      extensions: a_kind_of(Array).or(a_nil_value),
      link: a_url.and(start_with('https://www.google.com/search')),
      image: a_string_starting_with('data:image/jpeg;base64,').or(a_url)
    }
  end

  describe '#results' do
    subject { parser.results[:artworks] }

    it { is_expected.to be_an(Array) }
    it { is_expected.to all(be_a(Hash)) }
    it { is_expected.to all(match(expected_attributes)) }

    it 'should have the correct first result' do
      expect(subject.first).to match(expected_first_result)
    end
  end
end

RSpec.describe GoogleSearch::Parser::ArtworkResults do
  it_behaves_like 'google artwork parser', 'spec/fixtures/van-gogh-paintings.html' do
    let(:expected_first_result) do
      {
        image: a_string_starting_with('data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQAB'),
        extensions: ['1889'],
        link: a_string_starting_with('https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night'),
        name: 'The Starry Night'
      }
    end
  end
end
