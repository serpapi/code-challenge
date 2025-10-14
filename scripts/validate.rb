require "json"
require "nokogiri"

USAGE = "Usage: ruby scripts/validate.rb <out.json> <expected-array.json> [input.html]"

abort(USAGE) if ARGV.length < 2 || ARGV.length > 3

out_path, expected_path, html_path = ARGV

out = JSON.parse(File.read(out_path, encoding: "UTF-8"))
exp = JSON.parse(File.read(expected_path, encoding: "UTF-8"))

def keys_of_first(arr)
  arr.is_a?(Array) && arr.any? ? arr.first.keys.sort : []
end

# ——— Core shape checks ———
ok_top = out.is_a?(Hash) && out["artworks"].is_a?(Array)
abort("❌ Output must be an object with an 'artworks' array.") unless ok_top

k_out = keys_of_first(out["artworks"])
k_exp = keys_of_first(exp["artworks"])
abort("❌ Key mismatch.\n out: #{k_out}\n exp: #{k_exp}") unless k_out == k_exp

abs_links = out["artworks"].all? { |h| h["link"].to_s.start_with?("http") }
abort("❌ Some links are not absolute URLs.") unless abs_links

# ——— Extensions sanity (array, ≤1 item, valid year if present) ———
YEAR_RE = /(?<!\d)(1[5-9]\d{2}|20\d{2})(?!\d)/

out["artworks"].each_with_index do |h, i|
  ext = h["extensions"]
  unless ext.is_a?(Array)
    abort("❌ Item #{i} (#{h["name"]}) has non-array 'extensions': #{ext.inspect}")
  end
  if ext.length > 1
    abort("❌ Item #{i} (#{h["name"]}) has more than one extension: #{ext.inspect}")
  end
  if ext.any? && !(ext.first.to_s =~ YEAR_RE)
    abort("❌ Item #{i} (#{h["name"]}) has non-year extension: #{ext.inspect}")
  end
end

# ——— Cross-check against the input HTML (if provided) ———
# ---- optional cross-check: enforce year only if the page shows a unique year for this title ----
if html_path && File.exist?(html_path)
  html = File.read(html_path, encoding: "UTF-8")
  doc  = Nokogiri::HTML(html)
  page_text = doc.text.gsub(/\s+/, " ")

  def all_years_for_title(text, title, year_re)
    t = Regexp.escape(title)
    years = []
    text.scan(/#{t}\s*#{year_re}/i) { years << $1 }
    text.scan(/#{t}\s*[-–]\s*Vincent\s+van\s+Gogh\s*#{year_re}/i) { years << $1 }
    years.uniq
  end

  mismatches = []
  out["artworks"].each do |h|
    years = all_years_for_title(page_text, h["name"].to_s, YEAR_RE)
    next if years.empty?      # nothing to enforce
    next if years.size > 1    # ambiguous on the page → don't enforce

    wanted = years.first
    got = h["extensions"].is_a?(Array) && h["extensions"].first
    mismatches << { name: h["name"], expected: wanted, got: h["extensions"] } unless got == wanted
  end

  unless mismatches.empty?
    lines = mismatches.first(10).map { |m| " - #{m[:name]} → expected [#{m[:expected]}], got #{m[:got].inspect}" }
    lines << " …and #{mismatches.size - 10} more" if mismatches.size > 10
    abort("❌ Some items are missing year in 'extensions' though uniquely present in HTML:\n#{lines.join("\n")}")
  end
end


puts "✅ Shape, links, and extension checks passed."
puts "ℹ️  HTML cross-check skipped (no input.html provided)." unless html_path
