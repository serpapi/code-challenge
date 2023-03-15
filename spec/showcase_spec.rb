require 'google'

RSpec.describe "Artworks" do
  subject(:artworks) { Google::SearchPage.new(file_path).artworks }

  let(:file_path) { File.expand_path("../files/van-gogh-paintings.html", __dir__) }

  describe "artwork item" do
    subject(:artwork) { artworks.first }

    it do
      expect(artwork.name).to be_a(String)
      expect(artwork.name).not_to be_empty
      expect(artwork.link).to match(%r{^https://www.google.com/search\?.+})
      expect(artwork.extensions).to be_an(Array)
      expect(artwork.name).not_to be_empty
      expect(artwork.image).to match(%r{data:image/jpeg;base64,.*})
    end
  end
end
