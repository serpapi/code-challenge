# frozen_string_literal: true

RSpec.describe Extractor do
  let(:test_pages) do
    %w[./files/van-gogh-paintings.html ./files/mc-escher-artwork.html ./files/hokusai-artwork.html]
  end

  # Placeholder used by google for images that are not loaded yet (because they
  # are in the truncated part of the knowledge panel). They shouldn't show up in
  # the extracted artworks because their alternative remote url should be
  # extracted instead.
  let(:placeholder_base64_image) do
    'data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=='
  end

  # Validates that the given artwork hash conforms to the expected structure.
  def validate_artwork(artwork, artwork_id)
    expect(artwork).to be_a(Hash), "Artwork ##{artwork_id} should be a hash, got #{artwork.class}"

    expect(artwork).to have_key(:name), "Artwork ##{artwork_id} should have a name"
    expect(artwork[:name]).to be_a(String), "Artwork ##{artwork_id} name should be a string, got #{artwork[:name].class}"
    expect(artwork[:name]).not_to be_empty, "Artwork ##{artwork_id} name should not be empty"

    if artwork.key?(:extensions) && !artwork[:extensions].nil?
      expect(artwork[:extensions]).to be_a(Array), "Artwork ##{artwork_id} extensions should be an array"
      if artwork[:extensions].any?
        artwork[:extensions].each do |extension|
          expect(extension).to be_a(String), "Artwork ##{artwork_id} each extension should be a string"
          expect(extension).not_to be_empty, "Artwork ##{artwork_id} extension should not be empty"
        end
      end
    end

    expect(artwork).to have_key(:link), "Artwork ##{artwork_id} should have a link"
    expect(artwork[:link]).to be_a(String), "Artwork ##{artwork_id} link should be a string, got #{artwork[:link].class}"
    expect(artwork[:link]).not_to be_empty, "Artwork ##{artwork_id} link should not be empty"
    expect(artwork[:link]).to match(/\Ahttps:\/\/www\.google\.com\//), "Artwork ##{artwork_id} link should be an absolute Google URL"

    expect(artwork).to have_key(:image), "Artwork ##{artwork_id} should have an image"
    expect(artwork[:image]).to be_a(String), "Artwork ##{artwork_id} image should be a string, got #{artwork[:image].class}"
    expect(artwork[:image]).not_to be_empty, "Artwork ##{artwork_id} image should not be empty"

    expect(artwork[:image]).to match(/\A(data:image\/(png|jpeg|gif);base64,|https)/), "Artwork ##{artwork_id} image should be a base64 encoded image or a URL"

    expect(artwork[:image]).not_to eq(placeholder_base64_image), "Artwork ##{artwork_id} image should not be the placeholder base64 image"
  end

  describe '.extract_artworks_from_serp_file' do
    it 'extracts artworks from all test HTML files' do
      test_pages.each do |page|
        artworks = described_class.extract_artworks_from_serp_file(page)

        expect(artworks).to be_a(Array), "Should return an array for #{page}"
        expect(artworks.length).to be > 0, "Should extract at least one artwork from #{page}"

        artworks.each_with_index do |artwork, index|
          validate_artwork(artwork, "#{page} ##{index + 1}")
        end
      end
    end

    it 'raises an error for non-existent file' do
      expect {
        described_class.extract_artworks_from_serp_file('./non-existent-file.html')
      }.to raise_error(Extractor::Error, /File not found/)
    end

    it 'raises an error for nil path' do
      expect {
        described_class.extract_artworks_from_serp_file(nil)
      }.to raise_error(ArgumentError, /Please provide the path/)
    end

    it 'raises an error for empty path' do
      expect {
        described_class.extract_artworks_from_serp_file('')
      }.to raise_error(ArgumentError, /Please provide the path/)
    end
  end

  describe '.extract_artworks_from_knowledge_panel' do
    it 'extracts artworks from HTML string' do
      page = test_pages.first
      html_content = File.read(page)
      artworks = described_class.extract_artworks_from_knowledge_panel(html_content)

      expect(artworks).to be_a(Array), 'Should return an array'
      expect(artworks.length).to be > 0, 'Should extract at least one artwork'

      artworks.each_with_index do |artwork, index|
        validate_artwork(artwork, "#{page} ##{index + 1}")
      end
    end

    it 'handles empty HTML' do
      artworks = described_class.extract_artworks_from_knowledge_panel('<html><body></body></html>')

      expect(artworks).to be_a(Array), 'Should return an array'
      expect(artworks.length).to eq(0), 'Should return empty array for HTML without artwork containers'
    end

    it 'handles malformed HTML' do
      artworks = described_class.extract_artworks_from_knowledge_panel('<html><body><div>invalid</div></body></html>')

      expect(artworks).to be_a(Array), 'Should return an array'
      expect(artworks.length).to eq(0), 'Should return empty array for malformed HTML'
    end
  end
end
