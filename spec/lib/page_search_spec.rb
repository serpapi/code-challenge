# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/page_search'

describe PageSearch do
  it 'should return searched page nodes' do
    file = File.open('./files/van-gogh-paintings.html')
    search = described_class.new(file, 'div.EDblX.DAVP1 div.MiPcId.klitem-tr.mlo-c a').search

    expect(search).to be_an(Nokogiri::XML::NodeSet)
  end
end
