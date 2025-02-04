require_relative '../parser'
require 'json'
RSpec.describe 'End-to-End Integration' do
  let(:sample_html) { File.read('spec/fixtures/van-gogh-paintings.html') }
  let(:expected_output) { JSON.parse(File.read('spec/fixtures/expected.json')) }

  it 'produces correct artwork data' do
    tokens = tokenize(sample_html)
    tree = parse(tokens)
    scripts = css(tree, 'script')
    image_map = extract_inline_js_images_google(scripts)

    artworks = css(tree,'.iELo6').map do |node|
      img_node = css_first(node, 'img')
      img_src = img_node[:attributes]["src"]

      if img_src.nil? || img_src.empty? || img_src == "data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
        img_src = img_node[:attributes]["data-src"]
      end

      if img_src.nil? || img_src.empty?
        img_id = img_node[:attributes]["id"]
        img_src = image_map[img_id]
      end

      href =  css_first(node,'a')[:attributes]["href"]
      link = href.empty? ? "" : "https://www.google.com" + css_first(node,'a')[:attributes]["href"]
      extension = css_first(node,'div.cxzHyb')[:text]
      name = css_first(node,'div.pgNMRc')[:text]

      artwork = {
        "name" => name,
        "extensions" => extension.empty? ? nil : [extension],
        "link" => link,
        "image" => img_src,
      }.compact
      artwork
    end

    expect(artworks).to match_array(expected_output['artworks'])
  end
end
