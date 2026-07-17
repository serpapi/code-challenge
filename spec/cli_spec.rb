# frozen_string_literal: true

require "json"
require "open3"
require "tmpdir"

RSpec.describe "bin/extract" do
  let(:project_root) { FixtureFiles::PROJECT_ROOT }
  let(:executable) { File.join(project_root, "bin", "extract") }
  let(:supplied_input) { File.join(project_root, "files", "van-gogh-paintings.html") }

  def run_cli(*arguments, chdir: project_root)
    environment = { "BUNDLE_GEMFILE" => nil, "RUBYOPT" => nil }
    Open3.capture3(environment, executable, *arguments, chdir: chdir)
  end

  it "prints the exact expected result as pretty JSON from outside the project directory" do
    expected_stdout = "#{JSON.pretty_generate(json_fixture("files", "expected-array.json"))}\n"

    Dir.mktmpdir("google-search-artwork-extractor") do |other_directory|
      stdout, stderr, status = run_cli(supplied_input, chdir: other_directory)

      expect(status.exitstatus).to eq(0)
      expect(stdout).to eq(expected_stdout)
      expect(stderr).to eq("")
    end
  end

  it "rejects a missing input argument with usage on stderr" do
    stdout, stderr, status = run_cli

    expect(status.exitstatus).to eq(64)
    expect(stdout).to eq("")
    expect(stderr).to eq("Usage: bin/extract HTML_FILE\n")
  end

  it "rejects extra input arguments with usage on stderr" do
    stdout, stderr, status = run_cli(supplied_input, supplied_input)

    expect(status.exitstatus).to eq(64)
    expect(stdout).to eq("")
    expect(stderr).to eq("Usage: bin/extract HTML_FILE\n")
  end

  it "reports a missing input file without writing to stdout" do
    missing_path = File.join(project_root, "files", "not-present.html")
    stdout, stderr, status = run_cli(missing_path)

    expect(status.exitstatus).to eq(66)
    expect(stdout).to eq("")
    expect(stderr).to eq("Could not read input file: #{missing_path}\n")
  end

  it "maps an extraction failure to a concise data error" do
    Dir.mktmpdir("google-search-artwork-extractor") do |directory|
      input = File.join(directory, "unsupported.html")
      File.binwrite(input, "<!doctype html><title>No artwork section</title>")

      stdout, stderr, status = run_cli(input)

      expect(status.exitstatus).to eq(65)
      expect(stdout).to eq("")
      expect(stderr).to eq("Extraction failed: Could not find Google's artwork section\n")
    end
  end
end
