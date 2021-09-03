require_relative '../../parsers/carousel_item'
require 'json'

describe Parsers::CarouselItem do
  subject { described_class.new(carousel_item_html) }

  let(:carousel_item_html) { carousel_html.css(*Parsers::Carousel::CAROUSEL_ITEM_SELECTOR).first }
  let(:carousel_html) { parsed_html.css(Parsers::KnowledgeGraph::CAROUSEL_SELECTOR).first }
  let(:parsed_html) { Nokogiri::HTML(File.open(file_path)) }
  let(:file_path) { 'files/van-gogh-paintings.html' }

  describe '#data' do
    it 'returns Hash with carousel item data' do
      expect(subject.data).to be_kind_of(Hash)
      expect(subject.data).to eq(
        {
          extensions: ['1889'],
          image: 'data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==',
          link: 'https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw',
          name: 'The Starry Night'
        }
      )
    end
  end
end
