# frozen_string_literal: true

require 'spec_helper'

describe Parser::Input::File do
  subject(:reader) { described_class.new(filename).read }

  let(:filename) { 'spec/support/data/test.html' }

  it 'reads a file' do
    expect(reader).to eq("test\n")
  end
end
