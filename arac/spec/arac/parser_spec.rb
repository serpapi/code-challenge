# frozen_string_literal: true

require 'arac/parser'

describe Arac::Parser do
  let(:html) do
    "<html><body><h1>Hello, world!</h1><p class='author'>SerpApi</p><img class='image' src='serpapi.jpg'/></body></html>"
  end
  let(:parser) { Arac::Parser.new(html) }

  describe '#initialize' do
    it 'parses the HTML content' do
      expect(parser.instance_variable_get(:@doc)).to be_a Nokogiri::HTML::Document
    end
  end

  describe '#extract' do
    it 'extracts nodes that match the provided selector' do
      nodes = parser.extract('h1')
      expect(nodes).to be_a Nokogiri::XML::NodeSet
      expect(nodes.first.text).to eq 'Hello, world!'
    end
  end

  describe '#apply_methods' do
    context 'when the node responds to the method' do
      it 'applies the method to the node' do
        nodes = parser.extract('.author')
        result = parser.apply_methods(nodes.first, [[:text]])
        expect(result).to eq 'SerpApi'
      end
    end

    context 'when the method involves arguments' do
      it 'applies the method with arguments to the node' do
        nodes = parser.extract('.image')
        result = parser.apply_methods(nodes.first, [[:attr, 'src']])
        expect(result).to eq 'serpapi.jpg'
      end
    end
  end
end
