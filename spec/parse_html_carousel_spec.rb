require 'nokogiri'
require 'json'
require 'rspec'

describe 'Van Gogh Paintings Scraper' do
  let(:file_path) { File.join(File.dirname(__FILE__), 'van-gogh-paintings.json') }
  let(:output_json) { 'van-gogh-paintings.json' }
  let(:expected_keys) { %w[knowledge_graph organic_results search_parameters search_information related_questions people_also_search_for related_searches pagination search_metadata] }
  let(:paintings) { JSON.parse(File.read(output_json)) }

  before(:all) do
    # Run the script before all tests
    load 'parse_html_carousel.rb'
  end

  it 'should generate a JSON file' do
    expect(File).to exist(output_json)
  end

  it 'should contain the expected top-level keys' do
    expect(paintings.keys).to match_array(expected_keys)
  end

  describe 'knowledge_graph' do
    it 'should have a title extracted from the input file' do
      expect(paintings['knowledge_graph']).to have_key('title')
      expect(paintings['knowledge_graph']['title']).not_to be_empty
    end

    it 'should have a description extracted from the input file' do
      expect(paintings['knowledge_graph']).to have_key('description')
      expect(paintings['knowledge_graph']['description']).not_to be_empty
    end

    it 'should have a people_also_search_for_link extracted from the input file' do
      expect(paintings['knowledge_graph']).to have_key('people_also_search_for_link')
      expect(paintings['knowledge_graph']['people_also_search_for_link']).not_to be_empty
    end

    it 'should have a Wikipedia link if present' do
      expect(paintings['knowledge_graph']).to have_key('source')
      expect(paintings['knowledge_graph']['source']['name']).to eq('Wikipedia')
    end

    it 'should include a list of artworks' do
      expect(paintings['knowledge_graph']['artworks']).to be_an_instance_of(Array)
      expect(paintings['knowledge_graph']['artworks'].first).to have_key('name')
      expect(paintings['knowledge_graph']['artworks'].first).to have_key('link')
    end
  end

  describe 'organic_results' do
    it 'should have multiple results' do
      expect(paintings['organic_results']).to be_an_instance_of(Array)
      expect(paintings['organic_results'].size).to be > 0
    end

    it 'each result should have a title, link, and snippet' do
      paintings['organic_results'].each do |result|
        expect(result).to have_key('title')
        expect(result).to have_key('link')
        expect(result).to have_key('snippet')
      end
    end
  end

  describe 'people_also_search_for' do
    it 'should have multiple results' do
      expect(paintings['people_also_search_for']).to be_an_instance_of(Array)
      expect(paintings['people_also_search_for'].size).to be > 0
    end

    it 'each result should have a name, link, image and source' do
      paintings['people_also_search_for'].each do |result|
        expect(result).to have_key('name')
        expect(result).to have_key('link')
        expect(result).to have_key('image')
        expect(result).to have_key('source')
      end
    end
  end

  describe 'related_searches' do
    it 'should have multiple results' do
      expect(paintings['related_searches']).to be_an_instance_of(Array)
      expect(paintings['related_searches'].size).to be > 0
    end

    it 'each result should have a query and link' do
      paintings['related_searches'].each do |result|
        expect(result).to have_key('query')
        expect(result).to have_key('link')
      end
    end
  end

  describe 'related_questions' do
    it 'should contain related questions if present' do
      expect(paintings['related_questions']).to be_an_instance_of(Array)
    end

    it 'each result should have a question' do
      paintings['related_questions'].each do |result|
        expect(result).to have_key('question')
      end
    end
  end

  describe 'pagination' do
    it 'should contain pagination information' do
      expect(paintings['pagination']).to have_key('current')
      expect(paintings['pagination']).to have_key('next')
      expect(paintings['pagination']['other_pages']).to be_a(Hash)
    end
  end

  describe 'search_parameters' do
    it 'should include search query and device information' do
      expect(paintings['search_parameters']).to have_key('google_domain')
      expect(paintings['search_parameters']['device']).to eq('desktop')
    end
  end

  describe 'search_metadata' do
    it 'should include google_url' do
      expect(paintings['search_metadata']).to have_key('google_url')
    end
  end
end
