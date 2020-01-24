require_relative 'spec_helper'

RSpec.describe ParseCarousel do
  subject { described_class.new }

  let(:html_str) do
    <<-HTML
      <div class="MiPcId klitem-tr mlo-c">
        <a class="klitem" aria-label="name" href="link">
          1
        </a>
      </div>
      <div class="MiPcId klitem-tr mlo-c">
        <a class="klitem" aria-label="name2" href="link2">
          2
        </a>
      </div>
    HTML
  end

  describe '::new' do
    context 'when html string is valid' do
      before do
        CarouselItem.should_receive(:new).exactly(2).times
      end

      it 'initializes the object with carousel items' do
        expect(subject).to be_a(described_class)

        subject.extract_carosel_items!(html_str)

        expect(subject.extracted_carosel_items).to eq(Array.new(2, nil))
      end
    end

    context 'when html string is invalid' do
      let(:html_str) { '' }

      it 'cannot parse anything out of an invalid string and just sets an empty array' do
        expect(subject).to be_a(described_class)
        expect(subject.extracted_carosel_items).to eq([])
      end
    end
  end

  describe '#to_json' do
    let(:carousel_items) do
      Array.new(10) do |i|
        instance_double(CarouselItem, to_h: { name: "name#{i}", extensions: [i.to_s], link: "link#{i}", image: "image#{i}" })
      end
    end

    it 'calls to_h on all CarouselItems then converts the array of hashes to a JSON string' do
      expect(subject).to be_a(described_class)

      subject.instance_variable_set(:@extracted_carosel_items, carousel_items)

      expect(subject.to_json).to eq(JSON.pretty_generate(carousel_items.map(&:to_h)))
    end
  end
end
