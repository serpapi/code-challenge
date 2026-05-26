require "carousel_extractor"

# Compares extractor output against an expected fixture, field by field.
class DebugComparator
  def initialize(html, expected)
    @results  = CarouselExtractor.new(html).extract
    @expected = expected.map { |a| a.transform_keys(&:to_sym) }
  end

  def mismatches
    @mismatches ||= compare.sum { |item| item[:mismatches].size }
  end

  def report
    compare.each do |item|
      puts "\n[#{item[:index]}] #{item[:name]}"
      item[:fields].each do |field, status|
        puts "  #{field}:\t#{status}"
      end
    end
    puts "\n#{mismatches} mismatch(es) across #{@results.length} items."
  end

  private

  def compare
    @compare ||= @results.each_with_index.map { |result, i| compare_item(result, i) }
  end

  def compare_item(result, idx)
    exp = @expected[idx]
    fields = {}
    item_mismatches = []

    %i[name extensions link image].each do |field|
      got_val = result[field]
      exp_val = exp&.[](field)

      if got_val == exp_val
        fields[field] = "✓"
        next
      end

      item_mismatches << field
      fields[field] = mismatch_label(got_val, exp_val)
    end

    { index: idx + 1, name: result[:name] || "(no name)", fields:, mismatches: item_mismatches }
  end

  def mismatch_label(got_val, exp_val)
    unless got_val.is_a?(String) && exp_val.is_a?(String)
      return "MISMATCH\n    expected: #{exp_val.inspect}\n    got:      #{got_val.inspect}"
    end

    pos = got_val.chars.zip(exp_val.chars).find_index { |a, b| a != b } || [got_val.length, exp_val.length].min
    "MISMATCH at char #{pos}\n    " \
      "expected: ...#{context_slice(exp_val, pos)}...\n    " \
      "got:      ...#{context_slice(got_val, pos)}..."
  end

  def context_slice(str, pos)
    str[([pos - 10, 0].max)..(pos + 20)]
  end
end
