require "spec_helper"
require "layouts/j_cuz_jd"

RSpec.describe Layouts::JCuzJd do
  subject(:layout) { described_class.new }

  it { expect(layout.item_selector).to eq(".jCuzJd") }
  it { expect(layout).to be_a(Layouts::GridTile) }

  describe "#link" do
    let(:node) { Nokolexbor::HTML('<div class="jCuzJd"><a href="https://www.google.com/search?q=Joaquin+Phoenix"></a></div>').css(".jCuzJd").first }

    it "preserves absolute href unchanged" do
      expect(layout.link(node)).to eq("https://www.google.com/search?q=Joaquin+Phoenix")
    end
  end
end
