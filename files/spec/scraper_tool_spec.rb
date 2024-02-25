# frozen_string_literal: true

require 'rspec'
require 'json'
require_relative '../scraper_tool'

describe ScraperTool do
  before do
    root_dir = File.expand_path('.')
    url = "#{root_dir}/files/expected-array.json"
    file = File.read(url)
    @data_hash = JSON.parse(file)
  end

  it 'runs' do
    expect(false).to be false
  end

  it 'initializes with a url' do
    root_dir = File.expand_path('.')
    url = "#{root_dir}/files/van-gogh-paintings.html}"

    tool = ScraperTool.new(url)

    expect(tool.url).to eq(url)
  end

  it 'returns json' do
    root_dir = File.expand_path('.')
    url = "#{root_dir}/files/van-gogh-paintings.html}"

    tool = ScraperTool.new(url)

    expect(JSON.parse(tool.scrape_carousel)).to eq(@data_hash)
  end

  # it 'returns empty json if file is not found' do
  # end
end
