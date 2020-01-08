# frozen_string_literal: true

RSpec.shared_examples 'search result shape' do
  it 'has a name' do
    expect(result[:name]).to be_a(String)
    expect(result[:name]).to_not be_empty
  end

  it 'has a link' do
    expect(result[:link]).to be_a(String)
    expect(result[:link]).to_not be_empty
    expect(result[:link]).to match(%r{https?://[\S]+})
  end

  it 'has an image' do
    expect(result[:image]).to be_a(String)
    expect(result[:image]).to_not be_empty
  end

  it 'has extensions' do
    expect(result[:extensions]).to be_a(Array)
    expect(result[:extensions]).to_not be_empty
    expect(result[:extensions]).to all(be_a(String))
  end
end
