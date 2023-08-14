describe Scraper do
  describe Scraper::SuperParser do
    context 'parse carousel' do
      before(:all) do 
        path =  "file://#{__dir__}/../../files/two-elements.html"
        @res = Scraper::SuperParser.new(path).results
        @item_one = @res[0]
        @item_two = @res[1]
      end

      it "size" do
        expect(@res.size).to be 2
      end

      it "title" do
        expect(@item_one[:name]).to be_eql('hello world')
        expect(@item_two[:name]).to be_eql('hello 2 world 2')
      end

      it "href" do
        expect(@item_one[:link]).to be_eql('https://www.google.com/foo')
        expect(@item_two[:link]).to be_eql('https://www.google.com/bar')
      end

      it "extensions" do
        expect(@item_one[:extensions]).to be_eql ['2023-08-11']
        expect(@item_two[:extensions]).to be_eql ['2023-08-12']
      end

      it 'image' do
        expect(@item_one[:image]).to be_eql('base64image')
        expect(@item_two[:image]).to be_nil
      end
    end
  end

  context 'no standaed carousel' do
    before(:all) do
      path =  "file://#{__dir__}/../files/one-elements.html"
      @res = Scraper::SuperParser.new(path).results
    end

    it "size" do
      expect(@res.size).to be 0
    end
  end

  context 'expected response' do
    before(:all) do
      path = "file://#{__dir__}/../../../files/van-gogh-paintings.html"
      @scraper = Scraper::SuperParser.new(path)
      @res = @scraper.results

      expected_response  = File.open('./files/expected-array.json').read
      @expected_response = JSON.parse "{#{expected_response}}"
      @artworks =  @expected_response["artworks"]
    end

    it "size" do
      expect(@artworks.size).to be_eql(@res.size)
    end

    it "attributes" do
      @artworks.each_with_index do |el,i|
        expect(el['name']).to be_eql(@res[i][:name])
        expect(el['link']).to be_eql(@res[i][:link])
        expect(el['extensions']).to be_eql(@res[i][:extensions])
      end
    end
  end
end
