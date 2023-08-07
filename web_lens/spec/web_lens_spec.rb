# frozen_string_literal: true

require 'web_lens'

RSpec.describe WebLens, '#parse' do
  context 'when the HTTP status code is not success'
  context 'when it is not a valid HTML page'
  context 'when the title is nil'
  context 'when the extensions are nil'
  context 'when it is not a Google search link'
  context 'when it is not a JPEG image'
  context 'when it is a blank GIF image'

  context 'when checking the Artworks' do
    before(:all) do
      @klass = described_class.new
      @klass.parse
    end

    it 'is expected to be a Hash' do
      json_data = JSON.parse(@klass.send(:json_data))

      expect(json_data).to be_a(Hash)
      expect(json_data).not_to be_empty
    end

    it 'contains the name, extensions, link and image for each object' do
      json_data = JSON.parse(@klass.send(:json_data))
      item = json_data['artworks'].first
      name, extensions, link, image = item.values_at('name', 'extensions', 'link', 'image')

      expect(name).not_to be_empty
      expect(extensions).not_to be_empty
      expect(link).not_to be_empty
      expect(image).not_to be_empty

      expect(name).to be_a(String)
      expect(extensions).to be_an(Array)
      expect(link).to be_a(String)
      expect(image).to be_a(String)
    end
  end
end
