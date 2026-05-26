require "spec_helper"
require "layouts/j_cuz_jd"

RSpec.describe Layouts::JCuzJd do
  subject(:layout) { described_class.new }

  it { expect(layout.item_selector).to eq(".jCuzJd") }
  it { expect(layout).to be_a(Layouts::GridTile) }
end
