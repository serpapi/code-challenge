# spec/tokenizer_spec.rb
require_relative '../parser'
require 'strscan'

RSpec.describe 'HTML Tokenizer' do
  describe '#tokenize' do
    it 'tokenizes simple tags' do
      html = "<div>Hello</div>"
      tokens = tokenize(html)

      expect(tokens[0].type).to eq(Tokens::OPENING_TAG)
      expect(tokens[0].tag_name).to eq('div')

      expect(tokens[1].type).to eq(Tokens::TEXT)
      expect(tokens[1].tag_name).to eq('Hello')

      expect(tokens[2].type).to eq(Tokens::CLOSING_TAG)
    end

    it 'handles self-closing tags' do
      html = "<img src='test.jpg'/>"
      tokens = tokenize(html)

      expect(tokens[0].type).to eq(Tokens::SELF_CLOSING_TAG)
      expect(tokens[0].tag_name).to eq('img')
      expect(tokens[0].attributes).to eq('src' => 'test.jpg')
    end
  end
end
