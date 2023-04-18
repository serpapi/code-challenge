# frozen_string_literal: true

require_relative 'lib/serp_api_json_parser'
require_relative '../lib/chris_api_html_parser'

# This file was downloaded from https://github.com/serpapi/test-knowledge-graph-desktop/blob/master/spec/knowledge_graph_claude_monet_paintings_spec.rb
# and modified to test my own wrapper around the json. The intent is/was to encapsulate
# the 'source of truth' json, into something a little more ruby-readable, for the purpose
# of testing my own parser
describe 'ChrisApi Html JSON Parser' do
  describe 'Knowledge Graph for Van Gogh Paintings' do
    def van_gogh_asset(ext)
      File.absolute_path format('%<path>s/../files/van-gogh-paintings.%<ext>s',
                                path: File.dirname(__FILE__), ext: ext.to_s)
    end

    let(:source_of_truth) { SerpApiDesktopJSON::KnowledgeGraphParser.new van_gogh_asset(:json) }
    subject { ChrisApiHtmlParser::KnowledgeGraph.new File.open(van_gogh_asset(:html)) }

    it 'title' do
      expect(subject.title).to be_a(String)
      expect(subject.title).to_not be_empty
      expect(subject.title).to eq(source_of_truth.title)
    end

    it 'image' do
      # NOTE: I'm pretty sure the source_of_truth is 'wrong' here, and
      # that what's being returned is some kind of dummy gif, that gets replaced
      # with a jpeg, via javascript, on page load
      expect(subject.image).to be_a(String)
      expect(subject.image).to_not be_empty
      expect(subject.image).to eq(source_of_truth.image)
    end

    it 'description' do
      expect(subject.description).to be_a(String)
      expect(subject.description).to_not be_empty
      expect(subject.description).to eq(source_of_truth.description)
    end

    it 'source' do
      expect(subject.source).to be_a(Hash)
      expect(subject.source).to_not be_empty
      expect(subject.source).to eq(source_of_truth.source)
    end

    it 'born' do
      expect(subject.born).to be_a(String)
      expect(subject.born).to_not be_empty
      expect(subject.born).to eq(source_of_truth.born)
    end

    it 'died' do
      expect(subject.died).to be_a(String)
      expect(subject.died).to_not be_empty
      expect(subject.died).to eq(source_of_truth.died)
    end

    it 'periods' do
      expect(subject.periods).to be_a(String)
      expect(subject.periods).to_not be_empty
      expect(subject.periods).to eq(source_of_truth.periods)
    end

    it 'education' do
      expect(subject.education).to be_a(String)
      expect(subject.education).to_not be_empty
      expect(subject.education).to eq(source_of_truth.education)
    end

    it 'artworks' do
      expect(subject.artworks).to be_a(Array)
      expect(subject.artworks).to_not be_empty
      expect(subject.artworks.length).to eq(source_of_truth.artworks.length)
    end

    it 'artworks - name' do
      expect(subject.artworks[0]['name']).to be_a(String)
      expect(subject.artworks[0]['name']).to_not be_empty
      expect(subject.artworks[0]['name']).to eq(source_of_truth.artworks[0]['name'])
    end

    it 'artworks - extensions' do
      expect(subject.artworks[0]['extensions']).to be_a(Array)
      expect(subject.artworks[0]['extensions']).to_not be_empty
      expect(subject.artworks[0]['extensions']).to eq(source_of_truth.artworks[0]['extensions'])
    end

    it 'artworks - link' do
      expect(subject.artworks[0]['link']).to be_a(String)
      expect(subject.artworks[0]['link']).to_not be_empty
      expect(subject.artworks[0]['link']).to eq(source_of_truth.artworks[0]['link'])
    end

    it 'artworks - image' do
      expect(subject.artworks[0]['image']).to be_a(String)
      expect(subject.artworks[0]['image']).to_not be_empty

      # NOTE: We have to execute the html in the DOM, in order to resolve this spec:
      # expect(subject.artworks[0]['image']).to eq(source_of_truth.artworks[0]['image'])
      pending
    end
  end
end
