# frozen_string_literal: true

require 'spec_helper'

describe Parser::Output::Json do
  subject(:renderer) { described_class.new.render(data) }

  let(:data) do
    [
      {
        'name' => 'name1',
        'extensions' => 'extensions1',
        'link' => 'link1',
        'image' => 'image1'
      },
      {
        'name' => 'name2',
        'extensions' => 'extensions2',
        'link' => 'link2',
        'image' => 'image2'
      }
    ].map do |item|
      Parser::Artworks::Google::BaseWorker::ResultItem.new(
        item['name'],
        item['link'],
        item['extensions'],
        item['image']
      )
    end
  end

  it 'renders a json' do
    expect(renderer).to eq('{"artworks":[{"name":"name1","extensions":"extensions1","link":'\
'"link1","image":"image1"},{"name":"name2","extensions":"extensions2","link":"link2",'\
'"image":"image2"}]}')
  end
end
