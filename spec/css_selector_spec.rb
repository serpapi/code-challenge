require_relative '../parser'

RSpec.describe 'CSS Selector' do
  let(:html) { "<div class='container'><p id='content'>Text</p></div>" }
  let(:tokens) { tokenize(html) }
  let(:root) { parse(tokens) }

  describe '#css' do
    it 'finds elements by class' do
      results = css(root, '.container')
      expect(results.size).to eq(1)
      expect(results.first.tag_name).to eq('div')
    end

    it 'finds elements by id' do
      results = css(root, '#content')
      expect(results.size).to eq(1)
      expect(results.first.tag_name).to eq('p')
    end
  end
end
