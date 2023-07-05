# frozen_string_literal: true

require 'arac/extractor'

describe Arac do
  let(:html) do
    "<html><body><h1>Hello, world!</h1><p class='author'>John Doe</p><p class='date'>2023-07-04</p></body></html>"
  end

  describe '.new' do
    it 'returns an instance of Extractor' do
      extractor = Arac.new {}
      expect(extractor).to be_a Arac::Extractor
    end
  end

  describe Arac::Extractor do
    context '#item' do
      it 'updates the output spec with a single item' do
        extractor = Arac.new do
          item :title, selector: 'h1', methods: [[:text]]
          item :author, selector: '.author', methods: [[:text]]
        end
        result = extractor.capture_from(html)
        expect(result).to eq({ title: 'Hello, world!', author: 'John Doe' })
      end
    end

    context '#items' do
      let(:html_multi) do
        "<html><body><p class='item'>Item 1</p><p class='item'>Item 2</p><p class='item'>Item 3</p></body></html>"
      end

      it 'updates the output spec with multiple items' do
        extractor = Arac.new do
          items :items, selector: '.item', methods: [[:text]]
        end
        result = extractor.capture_from(html_multi)
        expect(result).to eq({ items: ['Item 1', 'Item 2', 'Item 3'] })
      end
    end

    context 'when an error occurs during extraction' do
      let(:faulty_html) { '<html><body><h1>Hello, world!</h1></body></html>' }

      it 'raises an ExtractionError' do
        extractor = Arac.new do
          item :title, selector: 'h1', methods: [[:txt]]
        end

        expect { extractor.capture_from(faulty_html) }.to raise_error(Arac::Extractor::ExtractionError)
      end
    end

    context 'when the item key is already used in the output spec' do
      it 'overwrites the previous item spec' do
        extractor = Arac.new do
          item :title, selector: 'h1', methods: [[:text]]
          item :title, selector: '.author', methods: [[:text]]
        end
        result = extractor.capture_from(html)
        expect(result[:title]).to eq('John Doe')  # title was overwritten with the author"s name
      end
    end

    context 'when different methods are used' do
      let(:html) { "<html><body><img class='image' src='my_image.jpg'/></body></html>" }

      it 'correctly applies the method' do
        extractor = Arac.new do
          item :image, selector: '.image', methods: [[:attr, 'src']]
        end
        result = extractor.capture_from(html)
        expect(result[:image]).to eq('my_image.jpg')
      end
    end
  end
end
