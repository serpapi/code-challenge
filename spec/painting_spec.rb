# frozen_string_literal: true

describe Painting do
  let(:doc) { Nokogiri::HTML(File.read('./spec/support/valid_html_data.html')) }
  let(:nodes) { doc.css('.klbar .klitem') }
  let(:parsed_results) { JSON.parse("{#{File.read('./spec/support/expected_results.json')}}")['artworks'] }

  describe '#id' do
    it 'correctly extracts the id' do
      subject = Painting.new(doc, nodes[0])

      expect(subject.id).to eq('kximg0')
    end
  end

  describe '#name' do
    it 'correctly extracts the name' do
      subject = Painting.new(doc, nodes[0])

      expect(subject.name).to eq(parsed_results[0]['name'])
    end
  end

  describe '#extensions' do
    context 'date present' do
      it 'returns the date wrapped in an array' do
        subject = Painting.new(doc, nodes[0])

        expect(subject.extensions).to eq(parsed_results[0]['extensions'])
      end
    end

    context 'extensions absent' do
      it 'returns nil' do
        # the third painting has no extensions
        subject = Painting.new(doc, nodes[2])

        expect(subject.extensions).to be_nil
      end
    end
  end

  describe '#link' do
    it 'returns the absolute url to the relevant search result' do
      subject = Painting.new(doc, nodes[0])

      expect(subject.link).to eq(parsed_results[0]['link'])
    end
  end

  describe '#img_src' do
    context 'image source present' do
      it 'correctly extracts image source for the first painting' do
        # we have to special case the extraction for the first image
        subject = Painting.new(doc, nodes[0])

        expect(subject.img_src).to eq(parsed_results[0]['image'])
      end

      it 'correctly extracts image source for subsequent paintings' do
        subject = Painting.new(doc, nodes[1])

        expect(subject.img_src).to eq(parsed_results[1]['image'])
      end
    end

    context 'image source absent' do
      it 'correctly returns nil' do
        # painting #11 has no image src
        subject = Painting.new(doc, nodes[10])

        expect(subject.img_src).to be_nil
      end
    end
  end

  describe '#to_h' do
    it 'returns a hash structure for jsonification' do
      subject = Painting.new(doc, nodes[0])
      result = subject.to_h.transform_keys(&:to_s)

      expect(result).to eq(parsed_results[0])
    end

    it 'always has an image key, even when image is nil' do
      subject = Painting.new(doc, nodes[10])
      result = subject.to_h

      expect(result.keys).to include(:image)
      expect(result[:image]).to be_nil
    end

    it 'does not include the extensions key when extensions is nil' do
      subject = Painting.new(doc, nodes[2])
      result = subject.to_h

      expect(result.keys).not_to include(:extensions)
    end
  end
end