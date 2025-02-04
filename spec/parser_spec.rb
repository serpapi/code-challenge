require_relative '../parser'

RSpec.describe 'HTML Parser' do
  let(:sample_html) { "<div><p>Test</p></div>" }
  let(:tokens) { tokenize(sample_html) }
  let(:root) { parse(tokens) }

  it 'builds correct node hierarchy' do
    div_node = root.children.first
    expect(div_node.tag_name).to eq('div')

    p_node = div_node.children.first
    expect(p_node.tag_name).to eq('p')
    expect(p_node.text).to eq('Test')
  end
end
