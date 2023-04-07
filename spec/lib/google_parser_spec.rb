
RSpec.describe GoogleParser do
  describe '#parse' do
    it "outputs hello world" do
      expect { GoogleParser.parse }.to output("hello world\n").to_stdout
    end
  end
end
