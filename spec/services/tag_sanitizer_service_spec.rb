# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagSanitizerService do
  subject { TagSanitizerService.new }

  let(:fixture_name_dirty) { 'dirty.html' }
  let(:fixture_dirty) { File.read("#{Rails.root}/spec/fixtures/#{fixture_name_dirty}") }

  describe '#simple_tags_sanitize' do
    it 'success' do
      expect(subject.simple_tags_sanitize(fixture_dirty)).to eq('<div></div>')
    end
  end

  describe '#tags_sanitize' do
    let(:html) { "<div><br/><span>#{expected_data}</span></div>" }
    let(:expected_data) { 'Test Name' }

    it 'success' do
      expect(subject.tags_sanitize(html)).to eq(expected_data)
    end
  end
end
