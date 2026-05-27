require "spec_helper"
require "layouts/text_nodes"
require "layouts/klitem_tr"

RSpec.describe Layouts::KlitemTr do
  subject(:layout) { described_class.new }

  it { expect(layout.item_selector).to eq("a.klitem-tr") }
  it { expect(layout.image_selector).to eq("img[id], img[data-src]") }

  let(:html) do
    <<~HTML
      <a class="klitem-tr" href="https://www.google.com/search?q=Brazil" aria-label="Brazil">
        <div class="klitem">
          <img class="VeBrne" id="_img1">
          <div class="FozYP">Brazil</div>
          <div class="FozYP">1985</div>
        </div>
      </a>
    HTML
  end

  let(:node) { Nokolexbor::HTML(html).css("a.klitem-tr").first }

  describe "#name" do
    it { expect(layout.name(node)).to eq("Brazil") }
  end

  describe "#extension" do
    it { expect(layout.extension(node)).to eq("1985") }
  end

  describe "#extension with multi-part title" do
    let(:html) do
      <<~HTML
        <a class="klitem-tr" href="https://www.google.com/search?q=Monty" aria-label="Monty Python and the Holy Grail">
          <div class="klitem">
            <img class="VeBrne" id="_img2">
            <div class="FozYP">Monty Python</div>
            <div class="FozYP">and the Holy Grail</div>
            <div class="FozYP">1975</div>
          </div>
        </a>
      HTML
    end

    it "returns the year, not a title fragment" do
      expect(layout.extension(node)).to eq("1975")
    end

    it "reads name from aria-label not FozYP" do
      expect(layout.name(node)).to eq("Monty Python and the Holy Grail")
    end
  end

  describe "#extension when absent" do
    let(:html) do
      <<~HTML
        <a class="klitem-tr" href="https://www.google.com/search?q=X" aria-label="X">
          <div class="klitem"></div>
        </a>
      HTML
    end

    it { expect(layout.extension(node)).to be_nil }
  end

  describe "#link" do
    it { expect(layout.link(node)).to eq("https://www.google.com/search?q=Brazil") }
  end

  describe "#link with relative href" do
    let(:html) do
      <<~HTML
        <a class="klitem-tr" href="/search?q=Brazil" aria-label="Brazil">
          <div class="klitem"></div>
        </a>
      HTML
    end

    it "returns an absolute URL" do
      expect(layout.link(node)).to eq("https://www.google.com/search?q=Brazil")
    end
  end
end
