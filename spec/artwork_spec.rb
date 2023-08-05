# frozen_string_literal: true

require 'nokogiri'
require_relative '../app/artwork'

RSpec.describe Artwork do
  let(:object) { described_class.new(node, nodes_id_source_map) }

  let(:node) { Nokogiri::HTML(node_html).css('a.klitem').first }
  let(:node_html) do
    <<~HTML
      <a class="klitem" aria-label="Portrait of Adeline Ravoux" aria-posinset="51" aria-setsize="51"
           data-sp="50,6,38" style="height:193px;width:120px" title="Portrait of Adeline Ravoux (1890)" role="button"
           data-hveid="197" data-ved="0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIxQE"
           href="/search?link_to_artwork"
        >
        <div class="klzc" style="margin-bottom:0">
          <div class="klic" style="height:120px;width:120px">
            <g-img class="BA0A6c" style="height:120px;width:120px;background-color:#ddd">
              <img id="kximg50" class="rISBZc M4dUYb" height="120" width="120" alt=""
                   data-src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmR9iWuhqp5vU6ZZ5_RvP9A5yswjdEPK35qoTsvewSXTIZ0AOV9K4G0XUtULINVH--Jpo"
              >
            </g-img>
          </div>
        </div>

        <div>
          <div class="kltat"><span>Portrait of</span>
            <wbr>
              <span>Adeline Ravoux</span>
              <wbr></wbr>
            </wbr>
          </div>

          <div class="ellip klmeta">1890</div>
        </div></a>
    HTML
  end

  shared_examples 'returns correct json' do
    it 'returns correct json data' do
      expect(object.to_h).to eq(expected_result)
    end
  end

  context 'when no image data' do
    let(:nodes_id_source_map) { {} }
    let(:expected_result) do
      {
        name: 'Portrait of Adeline Ravoux',
        extensions: ['1890'],
        link: 'https://www.google.com/search?link_to_artwork',
        image: nil,
      }
    end

    include_examples 'returns correct json'
  end

  context 'when image data exists' do
    let(:nodes_id_source_map) { { 'kximg50' => 'image_source_data' } }
    let(:expected_result) do
      {
        name: 'Portrait of Adeline Ravoux',
        extensions: ['1890'],
        link: 'https://www.google.com/search?link_to_artwork',
        image: 'image_source_data',
      }
    end

    include_examples 'returns correct json'
  end
end
