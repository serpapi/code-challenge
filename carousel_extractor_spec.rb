require 'rspec'
require_relative 'carousel_extractor'
require 'nokogiri'
require 'selenium-webdriver'
require 'json'

RSpec.describe CarouselExtractor do
  let(:base_url) { 'https://www.google.com' }

  describe '#call' do
    before do
      allow_any_instance_of(Selenium::WebDriver::Driver).to receive(:get).and_call_original
      allow_any_instance_of(Selenium::WebDriver::Driver).to receive(:page_source).and_call_original
    end

    after do
      Selenium::WebDriver.quit rescue nil
    end

    context 'when testing van-gogh-paintings.html with expected-array.json' do
      let(:url) { "file://#{File.expand_path('./files/van-gogh-paintings.html')}" }
      let(:extractor) { CarouselExtractor.new(url, base_url) }

      before do
        @json_output = JSON.parse(extractor.call)
      end

      it 'matches the expected JSON output exactly' do
        expected_output = JSON.parse(File.read(File.expand_path('./files/expected-array.json')))
        expect(@json_output).to eq(expected_output)
      end
    end

    context 'when testing different files for structural integrity' do
      shared_examples 'validates structure' do |file_path|
        let(:url) { "file://#{File.expand_path("./files/#{file_path}")}" }
        let(:extractor) { CarouselExtractor.new(url, base_url) }

        before do
          @json_output = JSON.parse(extractor.call)
        end

        it "contains a valid structure for #{file_path}" do
          expect(@json_output).not_to be_empty
        end

        it "validates keys and values for #{file_path}" do
          @json_output.each do |key, value|
            expect(key).to be_a(String)
            expect(key).not_to be_empty
            expect(value).to be_an(Array)
            expect(value).not_to be_empty
          end
        end

        it "validates each item for #{file_path}" do
          @json_output.each do |_, value|
            value.each do |item|
              expect(item['name']).to be_a(String)
              expect(item['name']).not_to be_empty
              expect(item['extensions']).to be_an(Array)
              expect(item['link']).to match(/^https?:\/\//)
              expect(item['link']).not_to be_empty
              expect(item['image']).to match(/^data:image/)
              expect(item['image']).not_to be_empty
            end
          end
        end
      end

      include_examples 'validates structure', 'van-gogh-paintings.html'
      include_examples 'validates structure', 'avatar-movies.html'
      include_examples 'validates structure', 'u2-albums.html'
    end
  end
end
