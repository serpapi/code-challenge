# frozen_string_literal: true

require 'rspec'
require 'json'
require_relative '../scraper_tool'

describe ScraperTool do
  before do
    root_dir = File.expand_path('.')
    url = "#{root_dir}/files/expected-array.json"
    file = File.read(url)
    @expected_result = JSON.parse(file)

    painting_url = "#{root_dir}/files/van-gogh-paintings.html"
    tool = ScraperTool.new(painting_url)
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

  # it 'returns json' do
  #   root_dir = File.expand_path('.')
  #   url = "#{root_dir}/files/van-gogh-paintings.html"

  #   tool = ScraperTool.new(url)

  #   expect(JSON.parse(tool.scrape_carousel)).to eq(@expected_result)
  # end

  # it 'returns empty json if file is not found' do
  # end
end
