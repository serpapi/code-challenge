require 'rspec'
require 'nokogiri'
require_relative '../app/knowledge_item'

describe KnowledgeItem do
  describe '#to_h' do
    let(:html_element) do
      Nokogiri::HTML(File.open('spec/fixtures/search_results.html')).css('.klitem').first
    end

    subject(:knowledge_item) do
      KnowledgeItem.new(html_element)
    end

    it 'sets the name' do
      expect(knowledge_item.to_h[:name]).to eq('The Starry Night')
    end

    it 'sets the extensions' do
      expect(knowledge_item.to_h[:extensions]).to eq(['1889'])
    end

    it 'sets the link' do
      expect(knowledge_item.to_h[:link]).to eq(CGI::unescapeHTML('/search?gl=us&amp;hl=en&amp;q=The+Starry+Night&amp;stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&amp;npsic=0&amp;sa=X&amp;ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw'))
    end

    it 'sets the image' do
      expect(knowledge_item.to_h[:image]).to eq('')
    end
  end
end