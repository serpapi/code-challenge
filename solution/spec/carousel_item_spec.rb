require_relative 'spec_helper'

RSpec.describe CarouselItem do
  subject { described_class.new(carousel_item_html) }

  let(:name) { 'name' }
  let(:extensions) { ['extension_1', 'extension_2'] }
  let(:link) { 'link' }
  let(:full_link) { URI.join(described_class::GOOGLE_ORIGIN, link).to_s }
  let(:image) { 'image' }

  let(:carousel_item_html) do
    Nokogiri::HTML(
      <<-HTML
        <div class="MiPcId klitem-tr mlo-c">
          <a class="klitem" aria-label="#{name}"href="#{link}">
            <div class="klzc">
              <div class="klic">
                <g-img>
                  <img src="#{image}">
                </g-img>
              </div>
            </div>
            <div>
              <div class="kltat">
                <span>Line 1</span><wbr>
                <span>Line 2</span><wbr>
              </div>
              <div class="ellip klmeta">#{extensions.first}</div>
              <div class="ellip klmeta">#{extensions.last}</div>
            </div>
          </a>
        </div>
      HTML
    ).css(ParseCarousel::CAROSEL_ITEMS_CSS).first
  end

  describe '::new' do
    context 'when html is valid' do
      it 'initializes the object with values for name, extensions, link, and image' do
        expect(subject.name).to eq(name)
        expect(subject.extensions).to eq(extensions)
        expect(subject.image).to eq(image)
      end

      it 'prepends the Google origin to the link' do
        expect(subject.link).to eq(full_link)
      end
    end

    context "when image has trailing '='s" do
      let(:image) { 'image==' }

      it "converts them to 'x3d's" do
        expect(subject.image).to eq('imagex3dx3d')
      end
    end
  end

  describe '#to_h' do
    context 'when it can successfully convert the object to a Hash' do
      it 'returns the hash' do
        expect(subject.to_h).to eq(
          name: name,
          extensions: extensions,
          link: full_link,
          image: image
        )
      end
    end
  end
end
