# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require 'rspec'
require 'json'
require_relative '../scraper_tool'

shared_examples 'scraper_tool' do |expected_file, url, keyword|
  before :all do
    root_dir = File.expand_path('.')
    expected_url = "#{root_dir}/files/#{expected_file}"
    file = File.read(expected_url)
    @expected_result = JSON.parse(file)

    test_url = "#{root_dir}/files/#{url}"
    tool = ScraperTool.new(test_url)
    @result_hash = JSON.parse(tool.scrape_carousel)
  end

  it 'has a keyword' do
    expect(@result_hash.keys).to eq(@expected_result.keys)
  end

  it 'has the expected number of results' do
    keyword = @result_hash.keys.first

    expect(@result_hash[keyword].length).to eq(@expected_result[keyword].length)
  end

  it 'has the expected keys' do
    keyword = @result_hash.keys.first
    first_result_keys = @result_hash[keyword].first.keys

    expect(first_result_keys).to eq(@expected_result[keyword].first.keys)
  end

  it 'has the expected result name value' do
    keyword = @result_hash.keys.first
    name = @result_hash[keyword].first['name']

    expect(name).to eq(@expected_result[keyword].first['name'])
  end

  it 'has the expected result extension values' do
    keyword = @result_hash.keys.first
    extensions = @result_hash[keyword].first['extensions']

    expect(extensions).to eq(@expected_result[keyword].first['extensions'])
  end

  it 'has the expected result link value' do
    keyword = @result_hash.keys.first
    link = @result_hash[keyword].first['link']

    expect(link).to eq(@expected_result[keyword].first['link'])
  end

  it 'has the expected result image value' do
    keyword = @result_hash.keys.first
    image = @result_hash[keyword].first['image']

    expect(image).to eq(@expected_result[keyword].first['image'])
  end

  it 'has the expected nil result image value' do
    keyword = @result_hash.keys.first
    image = @result_hash[keyword].last['image']

    expect(image).to be_nil
  end
end

describe ScraperTool do
  describe 'Van Gogh' do
    include_examples 'scraper_tool', 'expected-array.json', 'van-gogh-paintings.html', 'artwork'

    it 'has the expected empty result extension values' do
      keyword = @result_hash.keys.first

      result_without_extensions = @result_hash[keyword].find { |hash| hash['extensions'].nil? }

      expect(result_without_extensions).to_not be(nil)
    end
  end

  describe 'Greenday' do
    include_examples 'scraper_tool', 'expected-greenday.json', 'greenday.html', 'members'

    it 'has the expected empty result extension values' do
      keyword = @result_hash.keys.first

      result_without_extensions = @result_hash[keyword].find { |hash| hash['extensions'].nil? }

      expect(result_without_extensions).to_not be(nil)
    end
  end
  
  describe 'Miyazaki' do
    include_examples 'scraper_tool', 'expected-miyazaki.json', 'miyazaki.html', 'movies'
  end
end

# rubocop:enable Metrics/BlockLength
