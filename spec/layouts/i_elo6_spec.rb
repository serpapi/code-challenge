require "spec_helper"
require "layouts/i_elo6"

RSpec.describe Layouts::IELo6 do
  subject(:layout) { described_class.new }

  it { expect(layout.item_selector).to eq(".iELo6") }
  it { expect(layout.image_selector).to eq("img[id], img[data-src]") }

  describe "#name" do
    let(:node) { Nokolexbor::HTML('<div class="iELo6"><div>The Starry Night</div></div>').css(".iELo6").first }

    it { expect(layout.name(node)).to eq("The Starry Night") }
  end

  describe "#extension" do
    let(:node) { Nokolexbor::HTML('<div class="iELo6"><div>The Starry Night</div><div>1889</div></div>').css(".iELo6").first }

    it { expect(layout.extension(node)).to eq("1889") }
  end

  describe "#extension when absent" do
    let(:node) { Nokolexbor::HTML('<div class="iELo6"></div>').css(".iELo6").first }

    it { expect(layout.extension(node)).to be_nil }
  end

  describe "#link" do
    let(:node) { Nokolexbor::HTML('<div class="iELo6"><a href="/search?q=Starry+Night"></a></div>').css(".iELo6").first }

    it "converts relative href to absolute" do
      expect(layout.link(node)).to eq("https://www.google.com/search?q=Starry+Night")
    end
  end
end
