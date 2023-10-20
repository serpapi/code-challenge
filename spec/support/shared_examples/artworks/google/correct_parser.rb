# frozen_string_literal: true

shared_examples 'a correct parser' do
  let(:folder) { "spec/support/data/sources/artworks/google/#{version}" }
  let(:input) { Parser::Input::File.new("#{folder}/#{painter}-paintings.html") }
  let(:expected_image) { File.open("#{folder}/#{painter}-image.txt").read }

  it 'correct parses name' do
    expect(worker['artworks'][0]['name']).to eq(expected_name)
  end

  it 'correct parses extensions' do
    expect(worker['artworks'][0]['extensions']).to eq(expected_extensions)
  end

  it 'correct parses link' do
    expect(worker['artworks'][0]['link']).to eq(expected_link)
  end

  it 'correct parses image' do
    expect(worker['artworks'][0]['image']).to eq(expected_image)
  end
end
