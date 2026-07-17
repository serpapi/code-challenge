# frozen_string_literal: true

require "google_search/artwork_extraction_benchmark"
require "google_search/artwork_extraction_benchmark_report"
require "open3"
require "rbconfig"

RSpec.describe GoogleSearch::ArtworkExtractionBenchmark do
  def measurement(ips, error_percent: 1.5)
    described_class::Measurement.new(ips: ips, error_percent: error_percent)
  end

  def measured_result(html, measurements: {})
    measurer = instance_double(described_class::ThroughputMeasurer)
    captured_jobs = nil
    allow(measurer).to receive(:call) do |jobs, warmup:, time:|
      captured_jobs = jobs
      expect(warmup).to eq(0.25)
      expect(time).to eq(0.5)

      jobs.to_h do |job|
        [ job.id, measurements.fetch(job.id, measurement(1000.0)) ]
      end
    end

    result = described_class.new(html, warmup: 0.25, time: 0.5, measurer: measurer).call
    [ result, captured_jobs ]
  end

  it "defaults to two seconds for warmup and measurement" do
    measurer = instance_double(described_class::ThroughputMeasurer)
    expect(measurer).to receive(:call) do |jobs, warmup:, time:|
      expect(warmup).to eq(2.0)
      expect(time).to eq(2.0)

      jobs.to_h { |job| [ job.id, measurement(1000.0) ] }
    end

    described_class.new("<!doctype html><title>No artworks</title>", measurer: measurer).call
  end

  it "leads with complete extraction and retains rule-backed diagnostics" do
    result, jobs = measured_result(fixture_file("files", "van-gogh-paintings.html"))

    expect(jobs.map(&:id)).to eq(
      %w[
        complete_extraction
        html_parsing
        locate_and_validate_cards
        structural_layout
        script_image_recovery
        artwork_output
      ]
    )
    expect(result.rows.map(&:id)).to eq(
      %w[
        complete_extraction
        html_parsing
        locate_and_validate_cards
        structural_layout
        script_image_recovery
        artwork_output
      ]
    )
    expect(result.primary_rows).to contain_exactly(
      have_attributes(
        id: "complete_extraction",
        label: "Complete artwork extraction",
        cards: 47,
        measurement: have_attributes(ips: 1000.0, error_percent: 1.5)
      )
    )
    expect(result.diagnostic_rows.map(&:label)).to eq(
      [
        "Parse HTML",
        "Locate and validate artwork cards",
        "Recover images stored in page scripts",
        "Build artwork output"
      ]
    )
    expect(result.diagnostic_rows.map(&:cards)).to eq([ nil, 47, 8, 47 ])
    expect(result.rule_rows).to contain_exactly(
      have_attributes(
        id: "structural_layout",
        label: "Validate already-located cards",
        cards: 47,
        measurement: have_attributes(ips: 1000.0, error_percent: 1.5)
      )
    )
    expect(result.supporting_rows.map(&:id)).to eq(
      %w[
        html_parsing
        locate_and_validate_cards
        structural_layout
        script_image_recovery
        artwork_output
      ]
    )
  end

  it "marks image recovery N/A when no artwork images are stored in page scripts" do
    result, jobs = measured_result(fixture_file("spec", "fixtures", "claude-monet-artworks.html"))

    expect(jobs.map(&:id)).to eq(
      %w[complete_extraction html_parsing locate_and_validate_cards structural_layout artwork_output]
    )
    expect(result.rows.map(&:id)).to eq(
      %w[
        complete_extraction
        html_parsing
        locate_and_validate_cards
        structural_layout
        script_image_recovery
        artwork_output
      ]
    )
    expect(result.primary_rows.map(&:cards)).to eq([ 50 ])
    expect(result.diagnostic_rows.map(&:cards)).to eq([ nil, 50, 0, 50 ])
    expect(result.diagnostic_rows.map(&:measurement)).to match(
      [
        have_attributes(ips: 1000.0),
        have_attributes(ips: 1000.0),
        nil,
        have_attributes(ips: 1000.0)
      ]
    )
    expect(result.rule_rows.map(&:cards)).to eq([ 50 ])
  end

  it "submits executable actions for every supported measurement" do
    executed_job_ids = []
    measurer = instance_double(described_class::ThroughputMeasurer)
    allow(measurer).to receive(:call) do |jobs, warmup:, time:|
      expect(warmup).to eq(0)
      expect(time).to eq(0.01)

      jobs.to_h do |job|
        job.action.call
        executed_job_ids << job.id
        [ job.id, measurement(1.0) ]
      end
    end

    result = described_class.new(
      fixture_file("files", "van-gogh-paintings.html"),
      warmup: 0,
      time: 0.01,
      measurer: measurer
    ).call

    expect(executed_job_ids).to eq(result.rows.map(&:id))
  end

  it "times only parsing when a readable page has no supported artwork root" do
    result, jobs = measured_result("<!doctype html><title>No artworks</title>")

    expect(jobs.map(&:id)).to eq([ "html_parsing" ])
    expect(result.primary_rows).to all(have_attributes(cards: nil, measurement: nil))
    expect(result.diagnostic_rows.map(&:measurement)).to match(
      [ have_attributes(ips: 1000.0, error_percent: 1.5), nil, nil, nil ]
    )
    expect(result.rule_rows).to all(have_attributes(cards: nil, measurement: nil))
  end

  it "raises for malformed artwork HTML when the section marker is present" do
    html = <<~HTML
      <div data-attrid="kc:/visual_art/visual_artist:works">
        <p>Artwork cards are missing</p>
      </div>
    HTML

    expect do
      measured_result(html)
    end.to raise_error(
      GoogleSearch::ArtworkLayoutError,
      "The artwork section contains no artwork cards"
    )
  end

  it "reports each operation separately without comparing unlike work" do
    measurements = {
      "html_parsing" => measurement(0.5, error_percent: 1.1),
      "locate_and_validate_cards" => measurement(3000.0, error_percent: 2.2),
      "structural_layout" => measurement(2_000_000.0, error_percent: 3.3),
      "script_image_recovery" => measurement(250.0, error_percent: 5.5),
      "artwork_output" => measurement(125.0, error_percent: 6.6),
      "complete_extraction" => measurement(50.0, error_percent: 4.4)
    }
    result, = measured_result(
      fixture_file("files", "van-gogh-paintings.html"),
      measurements: measurements
    )
    report = GoogleSearch::ArtworkExtractionBenchmarkReport.new(
      path: "/tmp/page.html",
      byte_size: 2048,
      warmup: 0.25,
      time: 0.5,
      result: result
    ).to_s

    expect(report).to include("Page: /tmp/page.html\nSize: 2,048 bytes; 2.0 KiB")
    expect(report).to include("benchmark-ips: 2.15.1")
    expect(report).to include("Primary workload")
    expect(report).to include("Diagnostics")
    expect(report).not_to include("Card rules")
    expect(report.scan(/^Operation +Cards +time\/run +runs\/s +variation$/).length).to eq(2)
    expect(report).not_to match(/^Rule +Cards/)
    expect(report).to match(/Complete artwork extraction +47 +20\.00 ms +50\.0 +±4\.4%/)
    expect(report).to match(/Parse HTML +- +2\.00 s +0\.5 +±1\.1%/)
    expect(report).to match(/Locate and validate artwork cards +47 +333\.33 μs +3000\.0 +±2\.2%/)
    expect(report).to match(/Validate already-located cards +47 +500\.00 ns +2000000\.0 +±3\.3%/)
    expect(report).to match(/Recover images stored in page scripts +8 +4\.00 ms +250\.0 +±5\.5%/)
    expect(report).to match(/Build artwork output +47 +8\.00 ms +125\.0 +±6\.6%/)
    expect(report.index("Complete artwork extraction")).to be < report.index("Parse HTML")
    expect(report.index("Locate and validate artwork cards")).to be <
      report.index("Validate already-located cards")
    expect(report.index("Validate already-located cards")).to be <
      report.index("Recover images stored in page scripts")
    expect(report.index("Recover images stored in page scripts")).to be <
      report.index("Build artwork output")
    expect(report).not_to include("vs structural")
    expect(report).to include("N/A means the page does not contain the content that operation needs.")

    table_lines = report.lines(chomp: true).grep(
      /\A(?:Operation|-|Complete artwork|Parse HTML|Locate and validate|Validate already-located|Recover images|Build artwork)/
    )
    expect(table_lines.map(&:length).max).to be <= 80
  end

  it "renders N/A for every metric when an operation is unsupported" do
    result, = measured_result("<!doctype html><title>No artworks</title>")
    report = GoogleSearch::ArtworkExtractionBenchmarkReport.new(
      path: "/tmp/unsupported.html",
      byte_size: 42,
      warmup: 0.25,
      time: 0.5,
      result: result
    ).to_s

    expect(report).to match(/Complete artwork extraction +N\/A +N\/A +N\/A +N\/A/)
    expect(report).to match(/Locate and validate artwork cards +N\/A +N\/A +N\/A +N\/A/)
    expect(report).to match(/Validate already-located cards +N\/A +N\/A +N\/A +N\/A/)
    expect(report).to match(/Recover images stored in page scripts +N\/A +N\/A +N\/A +N\/A/)
    expect(report).to match(/Build artwork output +N\/A +N\/A +N\/A +N\/A/)
  end

  it "rejects invalid measured throughput instead of rendering an invalid duration" do
    aggregate_failures do
      [ 0.0, -1.0, Float::NAN, Float::INFINITY ].each do |ips|
        result, = measured_result(
          "<!doctype html><title>No artworks</title>",
          measurements: { "html_parsing" => measurement(ips) }
        )
        report = GoogleSearch::ArtworkExtractionBenchmarkReport.new(
          path: "/tmp/invalid-measurement.html",
          byte_size: 42,
          warmup: 0.25,
          time: 0.5,
          result: result
        )

        expect { report.to_s }.to raise_error(
          ArgumentError,
          "Benchmark rate must be a positive finite number"
        )
      end
    end
  end

  it "rejects invalid measured variation" do
    [ -1.0, Float::NAN, Float::INFINITY ].each do |error_percent|
      result, = measured_result(
        "<!doctype html><title>No artworks</title>",
        measurements: {
          "html_parsing" => measurement(1.0, error_percent: error_percent)
        }
      )
      report = GoogleSearch::ArtworkExtractionBenchmarkReport.new(
        path: "/tmp/invalid-variation.html",
        byte_size: 42,
        warmup: 0.25,
        time: 0.5,
        result: result
      )

      expect { report.to_s }.to raise_error(
        ArgumentError,
        "Benchmark variation must be a nonnegative finite number"
      )
    end
  end

  it "can be required directly and handles unsupported HTML" do
    library_path = File.join(FixtureFiles::PROJECT_ROOT, "lib")
    script = <<~RUBY
      require "google_search/artwork_extraction_benchmark"

      measurer = Object.new
      def measurer.call(jobs, warmup:, time:)
        measurement = GoogleSearch::ArtworkExtractionBenchmark::Measurement
        jobs.to_h { |job| [ job.id, measurement.new(ips: 1.0, error_percent: 0.0) ] }
      end

      result = GoogleSearch::ArtworkExtractionBenchmark.new(
        "<title>No artworks</title>",
        warmup: 0,
        time: 0.01,
        measurer: measurer
      ).call
      abort unless result.rule_rows.all? { |row| row.measurement.nil? }
    RUBY

    stdout, stderr, status = Open3.capture3(RbConfig.ruby, "-I#{library_path}", "-e", script)

    expect(status.exitstatus).to eq(0)
    expect(stdout).to eq("")
    expect(stderr).to eq("")
  end
end
