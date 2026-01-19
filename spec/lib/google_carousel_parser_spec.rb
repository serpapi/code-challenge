require 'spec_helper'
require_relative '../../lib/google_carousel_parser'

RSpec.describe GoogleCarouselParser do
  subject(:results) { described_class.new(html).call }

  Dir[File.expand_path('files/*')].entries.each do |folder|
    context "when carousel is #{folder.split('/').last}" do
      let(:html) { File.read("#{folder}/index.html") }
      let(:json){ JSON.parse(File.read("#{folder}/expected-array.json")) }

      it 'parses correctly' do
        expect(results).to eq json
      end
    end
  end
end
