require_relative '../van_gogh_paintings.rb'
RSpec.describe VanGoghPaintings do
  before(:context) do
    # This block will run once before any examples in this spec file
    # Load a file or perform any necessary setup here
    html_file_path = './files/van-gogh-paintings.html'
    my_instance = VanGoghPaintings.new(html_file_path)
    @artworks = my_instance.artworks
  end
  it 'should test VanGoghPaintings' do
    expect(@artworks[:artworks]).to be_an(Array)
  end
  it "title" do
    expect(@artworks[:artworks][0][:name]).to be_a(String)
    expect(@artworks[:artworks][0][:name]).to_not be_empty
  end
  it "extensions" do
    expect(@artworks[:artworks][0][:extensions]).to be_a(Array)
    expect(@artworks[:artworks][0][:extensions]).to_not be_empty
  end
  it "link" do
    expect(@artworks[:artworks][0][:link]).to be_a(String)
    expect(@artworks[:artworks][0][:link]).to_not be_empty
  end
  it "image" do
    expect(@artworks[:artworks][0][:image]).to be_a(String)
    expect(@artworks[:artworks][0][:image]).to_not be_empty
  end
  it "no error" do
    expect(@artworks[:artworks][0][:error]).to be_nil
  end

  describe "nil" do
    before(:context) do
      # This block will run once before any examples in this spec file
      # Load a file or perform any necessary setup here
      html_file_path = nil
      @my_instance = VanGoghPaintings.new(html_file_path)
    end
    it "error with no file" do
      expect(@my_instance.error).to eq("No File")
    end
  end
end

