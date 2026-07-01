# frozen_string_literal: true

RSpec.describe GoogleSearchParser do
  def fixture(name)
    File.read(File.expand_path("../fixtures/#{name}", __dir__))
  end

  let(:result) { described_class.new(fixture("weather_austin_desktop_2025_03_14.html")).parse }

  it "returns an answer_box hash" do
    expect(result[:answer_box]).to be_a(Hash)
  end

  describe "answer_box" do
    let(:answer_box) { result[:answer_box] }

    it "has proper weather result type" do
      expect(answer_box[:type]).to eq(:weather_result)
    end

    {
      temperature: String,
      unit: String,
      precipitation: String,
      humidity: String,
      wind: String,
      location: String,
      weather: String,
      date: String
    }.each do |attribute, type|
      it "has #{attribute}" do
        expect(answer_box[attribute]).to be_a(type)
        expect(answer_box[attribute]).not_to be_empty if answer_box[attribute].respond_to?(:empty?)
      end
    end
  end

  it "returns organic_results array" do
    expect(result[:organic_results]).to be_an(Array)
    expect(result[:organic_results]).not_to be_empty
  end

  describe "organic_results" do
    let(:organic_results) { result[:organic_results] }

    {
      position: Integer,
      title: String,
    }.each do |attribute, type|
      it "has #{attribute}" do
        organic_results.each do |organic_result|
          expect(organic_result[attribute]).to be_a(type)
          expect(organic_result[attribute]).not_to be_empty if organic_result[attribute].respond_to?(:empty?)
        end
      end
    end
  end
end
