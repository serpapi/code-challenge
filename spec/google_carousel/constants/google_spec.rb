require 'rspec_helper'

describe GoogleCarousel::Constants::Google do
  it 'returns google base_url value correctly' do
    expect(described_class.base_url).to eq('https://www.google.com')
  end
end
