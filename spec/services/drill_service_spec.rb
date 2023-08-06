# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DrillService do
  subject { DrillService.new }

  let(:fixture_name) { 'google_van_gogh_result.html' }
  let(:fixture) { File.read("#{Rails.root}/spec/fixtures/#{fixture_name}") }

  let(:fixture_name_drilled) { 'google_van_gogh_result_drilled.html' }
  let(:fixture_drilled) { File.read("#{Rails.root}/spec/fixtures/#{fixture_name_drilled}") }

  let(:map) do
    [
      { element: 'html', strategy: 'drill' },
      { element: 'head', strategy: 'skip' },
      { element: 'body', strategy: 'drill' },
      { element: 'div', strategy: 'skip' },
      { element: 'noscript', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'noscript', strategy: 'skip' },
      { element: 'style', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'drill' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'span', strategy: 'skip' },
      { element: 'div', strategy: 'drill' },
      { element: 'script', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'script', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'style', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'drill' },
      { element: 'h1', strategy: 'skip' },
      { element: 'div', strategy: 'drill' },
      { element: 'div', strategy: 'drill' },
      { element: 'div', strategy: 'drill' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'drill' },
      { element: 'div', strategy: 'skip' },
      { element: 'div', strategy: 'drill' },
      { element: 'div', strategy: 'drill' },
      { element: 'g-scrolling-carousel', strategy: 'drill' },
      { element: 'div', strategy: 'drill' },
      { element: 'div', strategy: 'drill' }
    ]
  end

  describe '#pick' do
    it 'success' do
      expect(subject.pick(fixture, map)).to eq(fixture_drilled)
    end
  end
end