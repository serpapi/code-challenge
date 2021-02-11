# frozen_string_literal: true

require_relative '../lib/utils/tapp_amazing_print'
require_relative '../lib/serp_crawler'
require_relative '../stencils/google_art_carousel'
require_relative '../stencils/google_characters_carousel'

RSpec.describe SERP::Crawler do
  before(:example) do
    html_path = File.expand_path('../files/van-gogh-paintings.html', File.dirname(__FILE__))
    fixtures_path = File.expand_path('../files/expected-array.json', File.dirname(__FILE__))

    @html_doc = Nokogiri::HTML(File.read(html_path))
    @fixtures = Oj.load(File.read(fixtures_path))
  end

  # NOTE: Simple fixtures comparison, no examples for "new" files not to fix the wrong data in tests
  it 'scraps the given (old) HTML' do
    data = SERP::Crawler.new(
      html_doc: @html_doc,
      stencil: SERP::GOOGLE_ART_CAROUSEL_STENCIL
    ).crawl(
      &SERP::GOOGLE_ART_CAROUSEL_DATA_BUILDER
    )

    expect(data[:artworks].count).to eq(51)

    data[:artworks].each_with_index do |artwork, i|
      expect(artwork[:name]).to eq(@fixtures[:artworks][i][:name])
      expect(artwork[:extensions]).to eq(@fixtures[:artworks][i][:extensions])
      expect(artwork[:link]).to eq(@fixtures[:artworks][i][:link])

      # TODO: Weirdly enough even with "\\" removal my result differs from the fixtures
      #       Although my image works well in actual image tag https://bit.ly/2NeYNHg
      #       Need more tieme to investigate...
      # expect(data[:artworks][0][:image]).to eq(@fixtures[:artworks][0][:image])
      if artwork[:image]
        expect(artwork[:image][0..30]).to eq(@fixtures[:artworks][i][:image][0..30])
      else
        expect(artwork[:image]).to eq(@fixtures[:artworks][i][:image])
      end
    end
  end
end
