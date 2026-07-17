# frozen_string_literal: true

require "benchmark/ips"
require "nokolexbor"

module GoogleSearch
  class ArtworkExtractionBenchmarkReport
    COLUMN_GAP = "  "

    def initialize(path:, byte_size:, warmup:, time:, result:, include_environment: true)
      @path = path
      @byte_size = byte_size
      @warmup = warmup
      @time = time
      @result = result
      @include_environment = include_environment
    end

    def to_s
      lines = []
      lines.concat(environment_lines) if @include_environment
      lines.concat([
        "Page: #{@path}",
        "Size: #{formatted_size}",
        "",
        "Primary workload",
        primary_table,
        "",
        "Diagnostics",
        diagnostic_table,
        "",
        "time/run is estimated; runs/s is completed runs per second.",
        "Variation is benchmark-ips relative standard deviation.",
        "N/A means the page does not contain the content that operation needs."
      ])

      lines.join("\n")
    end

    private
      def environment_lines
        [
          "Artwork extraction benchmark",
          "Ruby: #{RUBY_DESCRIPTION}",
          "Nokolexbor: #{Nokolexbor::VERSION}",
          "benchmark-ips: #{Benchmark::IPS::VERSION}",
          "Warmup: #{seconds(@warmup)} | Measurement: #{seconds(@time)}",
          ""
        ]
      end

      def formatted_size
        kibibytes = @byte_size.fdiv(1024)
        "#{delimited_integer(@byte_size)} bytes; #{format("%.1f", kibibytes)} KiB"
      end

      def seconds(value)
        "#{format("%.2f", value)} s"
      end

      def primary_table
        measurement_table("Operation", @result.primary_rows)
      end

      def diagnostic_table
        measurement_table("Operation", @result.supporting_rows)
      end

      def measurement_table(label_header, result_rows)
        rows = result_rows.map do |row|
          measurement = row.measurement
          [
            row.label,
            formatted_cards(row),
            formatted_iteration_time(measurement),
            formatted_ips(measurement),
            formatted_variation(measurement)
          ]
        end

        table([ label_header, "Cards", "time/run", "runs/s", "variation" ], rows)
      end

      def formatted_cards(row)
        return "N/A" unless row.measurement
        return "-" unless row.cards

        row.cards.to_s
      end

      def formatted_ips(measurement)
        measurement ? format("%.1f", measurement.ips) : "N/A"
      end

      def formatted_iteration_time(measurement)
        return "N/A" unless measurement

        ips = measurement.ips
        unless ips.positive? && ips.finite?
          raise ArgumentError, "Benchmark rate must be a positive finite number"
        end

        nanoseconds = 1_000_000_000.fdiv(ips)
        Benchmark::IPS::Helpers.humanize_duration(nanoseconds)
      end

      def formatted_variation(measurement)
        return "N/A" unless measurement

        error_percent = measurement.error_percent
        unless error_percent.finite? && !error_percent.negative?
          raise ArgumentError, "Benchmark variation must be a nonnegative finite number"
        end

        format("±%.1f%%", error_percent)
      end

      def table(headers, rows)
        widths = column_widths([ headers, *rows ])
        formatted_header = format_table_row(headers, widths)
        formatted_rows = rows.map { |row| format_table_row(row, widths) }

        [
          formatted_header,
          "-" * formatted_header.length,
          *formatted_rows
        ].join("\n")
      end

      def column_widths(rows)
        rows.first.each_index.map do |index|
          rows.map { |row| row.fetch(index).length }.max
        end
      end

      def format_table_row(row, widths)
        row.each_with_index.map do |value, index|
          index.zero? ? value.ljust(widths[index]) : value.rjust(widths[index])
        end.join(COLUMN_GAP)
      end

      def delimited_integer(number)
        number.to_s.reverse.scan(/.{1,3}/).join(",").reverse
      end
  end
end
