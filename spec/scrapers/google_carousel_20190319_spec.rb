# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Scrapers::GoogleCarousel20190319 do
  context 'Van Gogh paintings' do
    raw_filepath = './files/van-gogh-paintings.html'
    json_filepath = './files/expected-array.json'
    it_behaves_like 'Google Carousel', raw_filepath, json_filepath
  end
end
