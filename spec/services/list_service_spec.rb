# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListService do
  subject { ListService.new }

  let(:fixture_name_drilled) { 'google_van_gogh_result_drilled.html' }
  let(:fixture_drilled) { File.read("#{Rails.root}/spec/fixtures/#{fixture_name_drilled}") }

  let(:fixture_name_painting_item) { 'google_van_gogh_painting_item.html' }
  let(:fixture_painting_item) { File.read("#{Rails.root}/spec/fixtures/#{fixture_name_painting_item}") }

  describe '#split' do
    it 'success' do
      items = subject.split(fixture_drilled, 'div')

      expect(items.count).to eq(51)
      expect(items.last).to eq(fixture_painting_item)
    end
  end
end