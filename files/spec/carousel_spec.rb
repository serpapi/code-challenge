require_relative '../parsers/google'

RSpec.describe Parser::Google do
  [
    'examples/amorsolo-paintings.html',
    'examples/brendan-fraser-movies.html',
    'examples/rene-magritte-paintings.html',
    'examples/the-beatles.html',
    'van-gogh-paintings.html'
  ].each do |file|
    before do
      parser = described_class.new(file)
      parser.parse_carousel

      @hash = parser.output
    end

    it 'parses the name' do
      expect(@hash.first[:name]).to_not be_empty
    end

    it 'parses the link' do
      expect(@hash.first[:link]).to start_with(Parser::Google::DOMAIN)
      expect(@hash.first[:link]).to_not be_empty
    end

    it 'parses the thumbnail' do
      expect(@hash.first[:image]).to_not be_empty
      expect(@hash.first[:image].length).to be > 1000
    end
  end
end
