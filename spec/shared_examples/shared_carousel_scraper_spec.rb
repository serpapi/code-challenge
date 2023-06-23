shared_examples_for 'a carousel scraper' do
  describe '#initialize' do
    it 'initializes with HTML content' do
      expect(scraper.instance_variable_get(:@doc)).to be_a(Nokogiri::HTML::Document)
    end
  end

  describe '#parse_items' do
    it 'returns an array of CarouselItems' do
      items = scraper.parse_items
      expect(items).to all(be_a(CarouselScraper::CarouselItem))
    end
  end

  describe '#fetch_encoded_images' do
    it 'returns a hash of encoded images' do
      images = scraper.send(:fetch_encoded_images)
      expect(images).to be_a(Hash)
      expect(images.values.first).to start_with("data:image/jpeg;base64")
    end
  end

  describe '#save_to_json_file' do
    after { File.delete(filename) if File.exist?(filename) }

    it 'saves the parsed items to a file in JSON format' do
      scraper.save_to_json_file(filename)
      expect(File).to exist(filename)
      json = JSON.parse(File.read(filename))
      expect(json).to be_an(Array)
      expect(json.first).to eq(JSON.parse(fixture))
    end
  end
end
