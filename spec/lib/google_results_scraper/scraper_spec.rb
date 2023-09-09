describe GoogleResultsScraper::Scraper do
  let(:input) { File.read(File.join('spec', 'fixtures', 'carousel-and-artwork-mural.html')) }
  subject { described_class.new(input).extract }

  it 'uses all the scrapers to extract the data' do
    expected_output = JSON.parse(File.read(File.join('spec', 'fixtures', 'carousel-and-artwork-mural.json')), symbolize_names: true)
    is_expected.to eq(expected_output)
  end

  it 'contains keys for each scraper' do
    is_expected
      .to have_key(:carousels)
      .and have_key(:artworks)
  end
end
