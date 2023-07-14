require_relative './../challenge/challenge'

describe 'Van Gogh Artwork' do
  before :all do
    file_path = File.expand_path('files/van-gogh-paintings.html')
    document = Challenge::HtmlFileParser.new(file_path).parse
    @results = Challenge::Parser.new(document).parse
  end

  describe 'Artwork Item' do
    before(:all) do
      @item = @results.first
    end

    it 'has a name' do
      expect(@item[:name]).to eql('The Starry Night')
    end

    it 'has an image' do
      expect(@item[:image]).to match(%r{^data:image/jpeg;base64})
    end

    it 'has link' do
      expect(@item[:link]).to match(%r{^https://www.google.com/search?})
    end

    it 'has extensions' do
      expect(@item[:extensions]).to be_an(Array)
    end

    context 'when there is no date on item' do
      before { @item = @results[2] }

      it 'does not have extensions' do
        expect(@item).not_to have_key(:extensions)
      end
    end

    context 'when thumbnail is not provided' do
      before { @item = @results.last }

      it 'has image set to nil' do
        expect(@item).to have_key(:image)
        expect(@item[:image]).to be_nil
      end
    end
  end

  describe 'Arwork Collection' do
    it 'is an array' do
      expect(@results).to be_an(Array)
    end

    it 'has an entry for all items' do
      expect(@results.size).to equal(51)
    end
  end
end
