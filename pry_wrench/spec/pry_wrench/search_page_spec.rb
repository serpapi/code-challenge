require 'spec_helper'

module PryWrench
  describe SearchPage do

    it 'just responds to scraped_items' do
      sp = SearchPage.new('')

      expect(sp).to respond_to(:scraped_items)
    end

  end
end
