require_relative '../lib/FileManager.rb'

RSpec.describe FileManager do
  # example of a simple test case
  describe '.write_to_file' do
    it 'writes data to a file' do
      # Setup
      file_path = 'files/new-van-gogh-paintings.json'
      data = [{ "name" => "The Starry Night", "extensions" => ["1889"] }]
      expected_content = '"artworks": ' + JSON.pretty_generate(data)

      # Exercise
      FileManager.write_to_file(file_path, data)

      # Verify
      expect(File.read(file_path)).to eq(expected_content)
      
      # Teardown
      File.delete(file_path) # clean up the file
    end
  end
end
