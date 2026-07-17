# frozen_string_literal: true

require "benchmark/ips"
require "nokolexbor"

require_relative "../google_search"
require_relative "artwork_layout_rules"
require_relative "artwork_page"
require_relative "artwork_extractor"

module GoogleSearch
  class ArtworkExtractionBenchmark
    DEFAULT_WARMUP = 2.0
    DEFAULT_TIME = 2.0

    Measurement = Data.define(:ips, :error_percent)
    Job = Data.define(:kind, :id, :label, :cards, :action)
    Row = Data.define(:kind, :id, :label, :cards, :measurement)
    Result = Data.define(:rows) do
      def primary_rows
        rows.select { |row| row.kind == :primary }
      end

      def diagnostic_rows
        rows.select { |row| row.kind == :diagnostic }
      end

      def rule_rows
        rows.select { |row| row.kind == :rule }
      end

      def supporting_rows
        rows.reject { |row| row.kind == :primary }
      end
    end

    class ThroughputMeasurer
      def call(jobs, warmup:, time:)
        report = Benchmark.ips(warmup: warmup, time: time, quiet: true) do |benchmark|
          jobs.each do |job|
            benchmark.report(job.id, &job.action)
          end
        end

        report.data.to_h do |result|
          ips = result.fetch(:ips)
          error_percent = result.fetch(:error).fdiv(ips) * 100

          [ result.fetch(:name), Measurement.new(ips: ips, error_percent: error_percent) ]
        end
      end
    end

    def initialize(html, warmup: DEFAULT_WARMUP, time: DEFAULT_TIME, measurer: ThroughputMeasurer.new)
      @html = html
      @warmup = warmup
      @time = time
      @measurer = measurer
    end

    def call
      normalized_html = html_for_parsing
      document = Nokolexbor::HTML(normalized_html)
      layout_rules = ArtworkLayoutRules.new(document)
      artwork_page = ArtworkPage.new(document, layout_rules: layout_rules)
      cards = cards_if_artwork_section_present(layout_rules)
      image_sources = artwork_page.recover_script_image_sources(cards) if cards

      jobs = [ extraction_job(cards) ]
      jobs << parsing_job(normalized_html)
      jobs << card_location_job(layout_rules, cards)
      jobs.concat rule_jobs(layout_rules, cards)
      jobs << script_image_recovery_job(artwork_page, cards)
      jobs << artwork_output_job(artwork_page, cards, image_sources)

      supported_jobs = jobs.select(&:action)
      measurements = @measurer.call(supported_jobs, warmup: @warmup, time: @time)
      rows = jobs.map do |job|
        Row.new(
          kind: job.kind,
          id: job.id,
          label: job.label,
          cards: job.cards,
          measurement: measurements[job.id]
        )
      end

      Result.new(rows: rows)
    end

    private
      def html_for_parsing
        html = @html.dup
        html.force_encoding(Encoding::UTF_8) if html.encoding == Encoding::BINARY
        html
      end

      def cards_if_artwork_section_present(layout_rules)
        layout_rules.cards
      rescue ArtworkSectionNotFound
        nil
      end

      def extraction_job(cards)
        return unsupported_extraction_job unless cards

        result = ArtworkExtractor.new(@html).call

        Job.new(
          kind: :primary,
          id: "complete_extraction",
          label: "Complete artwork extraction",
          cards: result.fetch("artworks").length,
          action: -> { ArtworkExtractor.new(@html).call }
        )
      end

      def unsupported_extraction_job
        Job.new(
          kind: :primary,
          id: "complete_extraction",
          label: "Complete artwork extraction",
          cards: nil,
          action: nil
        )
      end

      def parsing_job(html)
        Job.new(
          kind: :diagnostic,
          id: "html_parsing",
          label: "Parse HTML",
          cards: nil,
          action: -> { Nokolexbor::HTML(html) }
        )
      end

      def card_location_job(layout_rules, cards)
        Job.new(
          kind: :diagnostic,
          id: "locate_and_validate_cards",
          label: "Locate and validate artwork cards",
          cards: cards&.length,
          action: cards ? -> { layout_rules.cards } : nil
        )
      end

      def rule_jobs(layout_rules, cards)
        ArtworkLayoutRules::RULES.map do |rule|
          applicable = cards && layout_rules.matches?(cards, rule)
          action = -> { layout_rules.matches?(cards, rule) } if applicable
          card_count = cards.length if applicable

          Job.new(
            kind: :rule,
            id: rule.fetch(:id),
            label: rule.fetch(:label),
            cards: card_count,
            action: action
          )
        end
      end

      def script_image_recovery_job(artwork_page, cards)
        card_count = artwork_page.script_image_count(cards) if cards
        action = -> { artwork_page.recover_script_image_sources(cards) } if card_count&.positive?

        Job.new(
          kind: :diagnostic,
          id: "script_image_recovery",
          label: "Recover images stored in page scripts",
          cards: card_count,
          action: action
        )
      end

      def artwork_output_job(artwork_page, cards, image_sources)
        action = -> { artwork_page.build_artworks(cards, image_sources) } if cards
        card_count = cards.length if cards

        Job.new(
          kind: :diagnostic,
          id: "artwork_output",
          label: "Build artwork output",
          cards: card_count,
          action: action
        )
      end
  end
end
