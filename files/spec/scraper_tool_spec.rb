# frozen_string_literal: true

require 'rspec'
require_relative '../scraper_tool'

describe ScraperTool do
  it 'runs' do
    expect(false).to be false
  end

  it 'initializes with a url' do
    root_dir = File.expand_path('.')
    url = "#{root_dir}/files/van-gogh-paintings.html}"

    tool = ScraperTool.new(url)

    expect(tool.url).to eq(url)
  end
end
