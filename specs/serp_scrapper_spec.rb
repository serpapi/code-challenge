# frozen_string_literal: true

require 'active_support/core_ext/hash/indifferent_access'

require_relative '../lib/utils/tapp_amazing_print'
require_relative '../lib/serp_scrapper'

RSpec.describe SERP::Scrapper do
  before(:example) do
    @scrapper = SERP::Scrapper.new
  end

  it 'raises ArgumentError on wrong scrapper' do
    # TODO: Cover error on scrapper arg other then :old/:new
  end

  # NOTE: Simple fixtures comparison
  it 'scraps the given (old) HTML' do
    html_path = File.expand_path('../files/van-gogh-paintings.html', File.dirname(__FILE__))
    fixtures_path = File.expand_path('../files/expected-array.json', File.dirname(__FILE__))

    html_doc = Nokogiri::HTML(File.read(html_path))
    fixtures = Oj.load(File.read(fixtures_path)).with_indifferent_access

    @scrapper.html_doc = html_doc
    @scrapper.result_key = :artworks
    @scrapper.scrapper = :old

    data = @scrapper.scrap
    fixtures_data = fixtures[:artworks]

    expect(data[:artworks].count).to eq(51)

    data[:artworks].each_with_index do |artwork, i|
      expect(artwork[:name]).to eq(fixtures_data[i][:name])
      expect(artwork[:extensions]).to eq(fixtures_data[i][:extensions])
      expect(artwork[:link]).to eq(fixtures_data[i][:link])
      expect(artwork[:image]).to eq(fixtures_data[i][:image])
    end
  end

  it 'scraps the new HTML' do
    {"x-files-characters" => 51, "the-big-lebowski-characters" => 48}.each do |test_path, result_count|
      html_path = File.expand_path("../files/#{test_path}.html", File.dirname(__FILE__))
      fixtures_path = File.expand_path("../files/#{test_path}.json", File.dirname(__FILE__))

      html_doc = Nokogiri::HTML(File.read(html_path))
      fixtures = Oj.load(File.read(fixtures_path)).with_indifferent_access

      @scrapper.html_doc = html_doc
      @scrapper.result_key = :characters
      @scrapper.scrapper = :new

      data = @scrapper.scrap
      fixtures_data = fixtures[:characters]

      expect(data[:characters].count).to eq(result_count)

      data[:characters].each_with_index do |character, i|
        expect(character[:name]).to eq(fixtures_data[i][:name])
        expect(character[:extensions]).to eq(fixtures_data[i][:extensions])
        expect(character[:link]).to eq(fixtures_data[i][:link])
        expect(character[:image]).to eq(fixtures_data[i][:image])
      end
    end
  end
end
