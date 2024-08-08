# frozen_string_literal: true

require 'spec_helper'

describe 'SerpApi Desktop JSON' do
  describe "Knowledge Graph for Vincent Van Gogh Paintings" do
    before :all do
      @html_file = 'files/van-gogh-paintings.html'
      @json = ExtractPaintings.parse_html(@html_file, format: :knowledge_graph)
    end

    it 'contains Knowledge Graph hash' do
      expect(@json).to be_an(Hash)
      expect(@json['knowledge_graph']).to be_an(Hash)
    end

    it 'title' do
      expect(@json['knowledge_graph']['title']).to be_a(String)
      expect(@json['knowledge_graph']['title']).to_not be_empty
    end

    it 'image' do
      expect(@json['knowledge_graph']['image']).to be_a(String)
      expect(@json['knowledge_graph']['image']).to_not be_empty
    end

    it 'description' do
      expect(@json['knowledge_graph']['description']).to be_a(String)
      expect(@json['knowledge_graph']['description']).to_not be_empty
    end

    it 'source' do
      expect(@json['knowledge_graph']['source']).to be_a(Hash)
      expect(@json['knowledge_graph']['source']).to_not be_empty
    end

    it 'born' do
      expect(@json['knowledge_graph']['born']).to be_a(String)
      expect(@json['knowledge_graph']['born']).to_not be_empty
    end

    it 'died' do
      expect(@json['knowledge_graph']['died']).to be_a(String)
      expect(@json['knowledge_graph']['died']).to_not be_empty
    end

    it 'periods' do
      expect(@json['knowledge_graph']['periods']).to be_a(String)
      expect(@json['knowledge_graph']['periods']).to_not be_empty
    end

    it 'education' do
      expect(@json['knowledge_graph']['education']).to be_a(String)
      expect(@json['knowledge_graph']['education']).to_not be_empty
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
