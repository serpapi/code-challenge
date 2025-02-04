require_relative '../parser'

RSpec.describe 'Image Extraction' do
  describe '#extract_inline_js_images' do
    it 'extracts image mappings from script content' do
      script_content = <<~JS
        var s='https://example.com/images/';
        var ii=['id1','id2'];
        var r = '';
        _setImagesSrc(ii,s,r);
      JS

      script_node = Node.new(
        tag_name: 'script',
        attributes: {},
        text: script_content,
        children: []
      )

      image_map = extract_inline_js_images_google([script_node])

      expect(image_map).to eq({
        'id1' => 'https://example.com/images/',
        'id2' => 'https://example.com/images/'
      })
    end
  end
end
