# frozen_string_literal: true

require 'json'

require_relative '../lib/google_artist_page'

describe GoogleArtistPage do
  let(:page) { described_class.new(file_path) }
  let(:artworks) { JSON.parse(page.artworks_json)['artworks'] }
  let(:first_artwork) { artworks.first }

  context 'Van Gogh Page' do
    let(:file_path) { 'files/van-gogh-paintings.html' }

    it 'has expected name' do
      expect(first_artwork['name']).to(be_a(String))
      expect(first_artwork['name']).to(eq('The Starry Night'))
    end

    it 'has expected extensions' do
      expect(first_artwork['extensions']).to(be_a(Array))
      expect(first_artwork['extensions']).to(eq(['1889']))
    end

    it 'has link' do
      expect(first_artwork['name']).to(be_a(String))
      expect(first_artwork['link']).to(start_with('https://www.google.com/search?sca_esv='))
    end

    it 'has image' do
      expect(first_artwork['name']).to(be_a(String))
      expect(first_artwork['image']).to(start_with('data:image/jpeg;base64'))
    end
  end

  context 'Architect (Frank Lloyd Wright) Page' do
    let(:file_path) { 'files/frank-lloyd-wright-buildings.html' }

    it 'has expected name' do
      expect(first_artwork['name']).to(eq('Fallingwater'))
    end

    it 'has no extensions array' do
      expect(first_artwork['extensions']).to(be(nil))
    end

    it 'has link' do
      expect(first_artwork['link']).to(start_with('https://www.google.com/search?sca_esv='))
    end

    it 'has image' do
      expect(first_artwork['image']).to(start_with('data:image/jpeg;base64'))
    end
  end

  context 'Musician (Alabama Shakes) Page' do
    let(:file_path) { 'files/alabama-shakes-albums.html' }

    it 'has expected name' do
      expect(first_artwork['name']).to(eq('Sound & Color'))
    end

    it 'has expected extensions' do
      expect(first_artwork['extensions']).to(eq(['2015']))
    end

    it 'has link' do
      expect(first_artwork['link']).to(start_with('https://www.google.com/search?sca_esv='))
    end

    it 'has image' do
      expect(first_artwork['image']).to(start_with('data:image/jpeg;base64'))
    end
  end

  fcontext 'Sculptor/Painter (Michelangelo) Page' do
    let(:file_path) { 'files/michelangelo-art.html' }

    it 'has expected name' do
      expect(first_artwork['name']).to(eq('Sistine Chapel ceiling'))
    end

    it 'has expected extensions' do
      expect(first_artwork['extensions']).to(eq(['1512']))
    end

    it 'has link' do
      expect(first_artwork['link']).to(start_with('https://www.google.com/search?sca_esv='))
    end

    it 'has image' do
      expect(first_artwork['image']).to(start_with('data:image/jpeg;base64'))
    end
  end
end
