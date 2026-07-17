# frozen_string_literal: true

require "open3"
require "tmpdir"

RSpec.describe "bin/benchmark" do
  let(:project_root) { FixtureFiles::PROJECT_ROOT }
  let(:executable) { File.join(project_root, "bin", "benchmark") }
  let(:supplied_input) { File.join(project_root, "files", "van-gogh-paintings.html") }
  let(:short_timing) { [ "--warmup", "0", "--time", "0.01" ] }

  def run_cli(*arguments, chdir: project_root)
    environment = { "BUNDLE_GEMFILE" => nil, "RUBYOPT" => nil }
    Open3.capture3(environment, executable, *arguments, chdir: chdir)
  end

  it "defaults to Van Gogh from outside the project" do
    Dir.mktmpdir("google-search-artwork-benchmark") do |other_directory|
      stdout, stderr, status = run_cli(*short_timing, chdir: other_directory)

      expect(status.exitstatus).to eq(0)
      expect(stderr).to eq("")
      expect(stdout).to include("Page: #{supplied_input}")
      expect(stdout).to include("Primary workload")
      expect(stdout).to include("Diagnostics")
      expect(stdout).not_to include("Card rules")
      expect(stdout.scan(/^Operation +Cards +time\/run +runs\/s +variation$/).length).to eq(2)
      expect(stdout).not_to match(/^Rule +Cards/)
      expect(stdout).to match(
        /Complete artwork extraction +47 +\d+\.\d{2} (?:ns|μs|ms|s) +\d+\.\d +±\d+\.\d%/
      )
      expect(stdout).to match(
        /Parse HTML +- +\d+\.\d{2} (?:ns|μs|ms|s) +\d+\.\d +±\d+\.\d%/
      )
      expect(stdout).to match(
        /Locate and validate artwork cards +47 +\d+\.\d{2} (?:ns|μs|ms|s) +\d+\.\d +±\d+\.\d%/
      )
      expect(stdout).to match(
        /Validate already-located cards +47 +\d+\.\d{2} (?:ns|μs|ms|s) +\d+\.\d +±\d+\.\d%/
      )
      expect(stdout).to match(
        /Recover images stored in page scripts +8 +\d+\.\d{2} (?:ns|μs|ms|s) +\d+\.\d +±\d+\.\d%/
      )
      expect(stdout).to match(
        /Build artwork output +47 +\d+\.\d{2} (?:ns|μs|ms|s) +\d+\.\d +±\d+\.\d%/
      )
    end
  end

  it "accepts another supported artwork page explicitly" do
    monet = File.join(project_root, "spec", "fixtures", "claude-monet-artworks.html")
    stdout, stderr, status = run_cli(*short_timing, monet)

    expect(status.exitstatus).to eq(0)
    expect(stderr).to eq("")
    expect(stdout).to match(/Complete artwork extraction +50 +\d+\.\d{2} (?:ns|μs|ms|s)/)
    expect(stdout).to match(/Locate and validate artwork cards +50 +\d+\.\d{2} (?:ns|μs|ms|s)/)
    expect(stdout).to match(/Validate already-located cards +50 +\d+\.\d{2} (?:ns|μs|ms|s)/)
    expect(stdout).to match(/Recover images stored in page scripts +N\/A +N\/A +N\/A +N\/A/)
    expect(stdout).to match(/Build artwork output +50 +\d+\.\d{2} (?:ns|μs|ms|s)/)
  end

  it "prints N/A rather than failing for a readable unsupported page" do
    Dir.mktmpdir("google-search-artwork-benchmark") do |directory|
      input = File.join(directory, "unsupported.html")
      File.binwrite(input, "<!doctype html><title>No artwork section</title>")

      stdout, stderr, status = run_cli(*short_timing, input)

      expect(status.exitstatus).to eq(0)
      expect(stderr).to eq("")
      expect(stdout).to match(/Complete artwork extraction +N\/A +N\/A +N\/A +N\/A/)
      expect(stdout).to match(/Locate and validate artwork cards +N\/A +N\/A +N\/A +N\/A/)
      expect(stdout).to match(/Validate already-located cards +N\/A +N\/A +N\/A +N\/A/)
      expect(stdout).to match(/Recover images stored in page scripts +N\/A +N\/A +N\/A +N\/A/)
      expect(stdout).to match(/Build artwork output +N\/A +N\/A +N\/A +N\/A/)
    end
  end

  it "fails for malformed artwork HTML when the section marker is present" do
    Dir.mktmpdir("google-search-artwork-benchmark") do |directory|
      input = File.join(directory, "malformed.html")
      File.binwrite(input, <<~HTML)
        <div data-attrid="kc:/visual_art/visual_artist:works">
          <p>Artwork cards are missing</p>
        </div>
      HTML

      stdout, stderr, status = run_cli(*short_timing, input)

      expect(status.exitstatus).to eq(65)
      expect(stdout).to eq("")
      expect(stderr).to eq(
        "Benchmark failed for #{input}: The artwork section contains no artwork cards\n"
      )
    end
  end

  it "accepts multiple pages in one invocation" do
    Dir.mktmpdir("google-search-artwork-benchmark") do |directory|
      first = File.join(directory, "first.html")
      second = File.join(directory, "second.html")
      File.binwrite(first, "<title>First</title>")
      File.binwrite(second, "<title>Second</title>")

      stdout, stderr, status = run_cli(*short_timing, first, second)

      expect(status.exitstatus).to eq(0)
      expect(stderr).to eq("")
      expect(stdout.scan(/^Artwork extraction benchmark$/).length).to eq(1)
      expect(stdout.scan(/^Ruby:/).length).to eq(1)
      expect(stdout.scan(/^Nokolexbor:/).length).to eq(1)
      expect(stdout.scan(/^benchmark-ips:/).length).to eq(1)
      expect(stdout.scan(/^Warmup:/).length).to eq(1)
      expect(stdout).to include("Page: #{first}", "Page: #{second}")
      expect(stdout.scan(/^Diagnostics$/).length).to eq(2)
    end
  end

  it "reports a missing file without starting a benchmark" do
    missing_path = File.join(project_root, "files", "not-present.html")
    stdout, stderr, status = run_cli(*short_timing, missing_path)

    expect(status.exitstatus).to eq(66)
    expect(stdout).to eq("")
    expect(stderr).to eq("Could not read input file: #{missing_path}\n")
  end

  it "rejects invalid timing options with usage" do
    stdout, stderr, status = run_cli("--time", "0")

    expect(status.exitstatus).to eq(64)
    expect(stdout).to eq("")
    expect(stderr).to include("invalid argument: --time must be greater than zero")
    expect(stderr).to include("Usage: bin/benchmark [options] [HTML_FILE ...]")
  end

  it "rejects non-finite timing options instead of starting an unbounded run" do
    %w[--warmup --time].each do |option|
      stdout, stderr, status = run_cli(option, "1e309")

      expect(status.exitstatus).to eq(64)
      expect(stdout).to eq("")
      expect(stderr).to include("invalid argument: #{option} must be finite")
    end
  end
end
