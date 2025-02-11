require "parse_utils"
require "rbconfig"
require "shellwords"

describe "main CLI" do
  it "outputs fixture correctly" do
    want = File.read("./files/expected-array.json")
    have = `#{RbConfig.ruby.shellescape} ./lib/main.rb ./files/van-gogh-paintings.html`
    expect($?.success?).to be true

    expect(JSON.parse(want)).to eq JSON.parse(have)
  end
end
