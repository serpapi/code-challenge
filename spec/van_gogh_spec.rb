require 'rspec'
require 'json'

require './parse.rb'

van_gogh_filename = './files/van-gogh-paintings.html'

expected = JSON.parse(File.read('./files/expected-array.json'), { symbolize_names: true })

describe 'parse' do
    before :all do
        @parsed = parse_carousel(van_gogh_filename)
    end

    it 'has the :arworks key' do
        expect(@parsed).to have_key(:artworks)
    end

    it 'extracts the van gogh painting carousel' do
        expect(@parsed[:artworks]).to match(expected[:artworks])
    end
end