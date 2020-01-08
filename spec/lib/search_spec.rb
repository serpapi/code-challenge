# frozen_string_literal: true

require 'spec_helper'

describe Search do
  let(:monet)       { File.expand_path('../html/monet.html', __dir__) }
  let(:van_gogh)    { File.expand_path('../html/van-gogh.html', __dir__) }
  let(:edgar_degas) { File.expand_path('../html/edgar-degas.html', __dir__) }

  context 'Monet results' do
    let(:monet_results) { Search.new(monet).extract! }

    it 'is an array of results' do
      expect(monet_results).to be_an(Array)
      expect(monet_results).to all(be_an(Hash))
    end

    subject(:result) { monet_results[0] }
    include_examples 'search result shape'
  end

  context 'Van Gogh results' do
    let(:van_gogh_results) { Search.new(van_gogh).extract! }

    it 'is an array of results' do
      expect(van_gogh_results).to be_an(Array)
      expect(van_gogh_results).to all(be_an(Hash))
    end

    subject(:result) { van_gogh_results[0] }
    include_examples 'search result shape'
  end

  context 'Edgar Degas results' do
    let(:edgar_degas_results) { Search.new(edgar_degas).extract! }

    it 'is an array of results' do
      expect(edgar_degas_results).to be_an(Array)
      expect(edgar_degas_results).to all(be_an(Hash))
    end

    subject(:result) { edgar_degas_results[0] }
    include_examples 'search result shape'
  end
end
