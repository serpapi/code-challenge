# frozen_string_literal: true

require 'spec_helper'

describe 'SerpApi Desktop JSON' do
  describe "Knowledge Graph for Salvador Dalí paintings" do
    before :all do
      @html_file = 'files/salvador-dali-paintings.html'
      @json = ExtractPaintings.parse_html(@html_file, recent: true, format: :knowledge_graph_reduced)
    end

    it 'contains Knowledge Graph hash' do
      expect(@json).to be_an(Hash)
      expect(@json['knowledge_graph']).to be_an(Hash)
    end

    it 'artworks' do
      expect(@json['knowledge_graph']['artworks']).to be_a(Array)
      expect(@json['knowledge_graph']['artworks']).to_not be_empty
    end

    it 'artworks - name' do
      expect(@json['knowledge_graph']['artworks'][0]['name']).to be_a(String)
      expect(@json['knowledge_graph']['artworks'][0]['name']).to_not be_empty
    end

    it 'artworks - extensions' do
      expect(@json['knowledge_graph']['artworks'][0]['extensions']).to be_a(Array)
      expect(@json['knowledge_graph']['artworks'][0]['extensions']).to_not be_empty
    end

    it 'artworks - link' do
      expect(@json['knowledge_graph']['artworks'][0]['link']).to be_a(String)
      expect(@json['knowledge_graph']['artworks'][0]['link']).to_not be_empty
    end

    it 'artworks - image' do
      # Note: some images could be nil
      expect(@json['knowledge_graph']['artworks'][0]['image']).to be_a(String)
      expect(@json['knowledge_graph']['artworks'][0]['image']).to_not be_empty
    end
  end
end
