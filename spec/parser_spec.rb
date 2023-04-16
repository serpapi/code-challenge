# frozen_string_literal: true

describe Parser do
  INFILE = './spec/support/valid_html_data.html'
  OUTFILE = './spec/support/parsed_results.json'
  EXPECTED_FILE = './spec/support/expected_results.json'

  before(:each) do
    File.delete(OUTFILE) if File.exists?(OUTFILE)
  end

  after(:each) do
    File.delete(OUTFILE) if File.exists?(OUTFILE)
  end

  describe '#execute!' do
    it 'parses the provided infile and writes the parsed results to the provided outfile' do

      described_class.execute!(INFILE, OUTFILE)

      expected_results = JSON.parse( "{#{File.read(EXPECTED_FILE)}}")
      parsed_results = JSON.parse(File.read(OUTFILE))

      expect(expected_results).to eq(parsed_results)
    end
  end

end