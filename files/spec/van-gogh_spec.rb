require 'van-gogh'

describe 'Scraper' do

  it 'checks if "van-gogh-paintings.html" exists' do
    expect(File.file?('van-gogh-paintings.html')).to be true
  end

  it 'checks if "van-gogh-paintings.html" is not empty' do
    f = File.read('van-gogh-paintings.html')
    expect(f).not_to be match("")
  end

  it 'checks if the "items" is nil' do
    s = Scraper.new
    test_array = s.scrape('van-gogh-paintings.html')
    expect(test_array[0]).not_to eq(nil)
  end

  it 'checks if the "items" is empty' do
    s = Scraper.new
    test_array = s.scrape('van-gogh-paintings.html')
    expect(test_array[0].length).to be > 0
  end

  it 'checks if "array_list" is empty' do
    s = Scraper.new
    test_array = s.scrape('van-gogh-paintings.html')
    expect(test_array[1].length).to be > 0
  end

  it 'checks if "image" does have "\\x" in it' do
    s = Scraper.new
    test_array = s.scrape('van-gogh-paintings.html')
    test_array[2].each do |image|
      if image != nil
        expect(image).not_to include("\\x")
      else
        true
      end
    end
  end
end
