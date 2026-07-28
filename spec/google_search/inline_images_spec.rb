# frozen_string_literal: true

require 'nokolexbor'
require_relative '../../lib/google_search/inline_images'

RSpec.describe GoogleSearch::InlineImages do
  def images_for(script)
    described_class.new(Nokolexbor::HTML("<html><body><script>#{script}</script></body></html>"))
  end

  it 'maps an img id to its data URI' do
    images = images_for("var s='data:image/jpeg;base64,abc123';var ii=['dimg_1'];_setImagesSrc(ii,s);")

    expect(images['dimg_1']).to eq('data:image/jpeg;base64,abc123')
  end

  it 'unescapes JS hex escapes in the data URI' do
    images = images_for("var s='data:image/jpeg;base64,abc\\x3d\\x3d';var ii=['dimg_1'];")

    expect(images['dimg_1']).to eq('data:image/jpeg;base64,abc==')
  end

  it 'maps every id when a script assigns several' do
    images = images_for("var s='data:image/png;base64,xyz';var ii=['dimg_1','dimg_2'];")

    expect(images['dimg_1']).to eq('data:image/png;base64,xyz')
    expect(images['dimg_2']).to eq('data:image/png;base64,xyz')
  end

  it 'returns nil for unknown ids' do
    expect(images_for('var unrelated = 1;')['dimg_1']).to be_nil
  end
end
