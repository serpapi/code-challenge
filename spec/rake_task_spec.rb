# frozen_string_literal: true

require 'rspec'
require 'open3'

describe 'Rake task artwork:extract' do
  let(:rake_cmd) { 'bundle exec rake artwork:extract[files/van-gogh-paintings.html]' }

  it 'runs successfully and outputs valid JSON with artworks' do
    stdout, stderr, status = Open3.capture3(rake_cmd)
    expect(status.exitstatus).to eq(0), "Rake task failed.\nSTDOUT:\n#{stdout}\nSTDERR:\n#{stderr}"
    data = JSON.parse(stdout)
    expect(data).to have_key('artworks')
    expect(data['artworks']).to be_a(Array)
    expect(data['artworks']).to_not be_empty
    expect(data['artworks'].first).to include('name', 'extensions', 'link', 'image')
  end
end
