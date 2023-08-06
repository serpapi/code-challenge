# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Google::PaintingService do
  subject { Google::PaintingService.new }

  let(:fixture_name_painting_item) { 'google_van_gogh_painting_item.html' }
  let(:fixture_painting_item) { File.read("#{Rails.root}/spec/fixtures/#{fixture_name_painting_item}") }

  let(:expected_data) do
    {
      name: 'Portrait of Adeline Ravoux',
      extensions: [
        '1890'
      ],
      image: nil,
      link: 'https://www.google.com/search?gl=us&amp;hl=en&amp;q=Portrait+of+Adeline+Ravoux&amp;stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1k_XNzQyyjYzTq7SUspOttIvyywuTcyJTywqQWJmFpdYlecXZRc_YozkFnj5456wVMCkNSevMXpxEaFJSIWLzTWvJLOkUkiKi0cKbrsGgxQXF5zHs4hVKiC_qKQoMbNEIT9NwTElNSczL1UhKLEsv7QCAOSAHzG2AAAA&amp;npsic=0&amp;sa=X&amp;ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIxQE'
    }
  end

  describe '#html_to_json' do
    it 'success' do
      expect(subject.html_to_json(fixture_painting_item)).to eq(expected_data)
    end
  end
end