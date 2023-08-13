# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Scrapers::GoogleCarousel20230813 do
  context 'Jan Matejko paintings' do
    raw_filepath = './files/jan-matejko-paintings.html'
    json_filepath = './files/expected-array-updated-matejko.json'
    it_behaves_like 'Google Carousel', raw_filepath, json_filepath
  end

  context 'Claude Monet paintings' do
    raw_filepath = './files/claude-monet-paintings.html'
    json_filepath = './files/expected-array-updated-monet.json'
    it_behaves_like 'Google Carousel', raw_filepath, json_filepath
  end
end
