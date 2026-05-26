require "spec_helper"
require "layouts/z8r5_gb"

RSpec.describe Layouts::Z8r5Gb do
  subject(:layout) { described_class.new }

  it { expect(layout.item_selector).to eq(".Z8r5Gb") }
  it { expect(layout).to be_a(Layouts::GridTile) }
end
