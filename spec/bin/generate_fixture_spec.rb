require "spec_helper"
require "carousel_extractor"
require "English"

RSpec.describe "bin/generate-fixture" do
  it "prints extracted results to stdout" do
    expect { system "bin/generate-fixture van-gogh-paintings" }
      .to output(a_string_including("The Starry Night"))
      .to_stdout_from_any_process
  end

  it "exits non-zero when the html fixture is missing" do
    system "bin/generate-fixture no-such-file"
    expect($CHILD_STATUS.exitstatus).to_not eq(0)
  end
end
