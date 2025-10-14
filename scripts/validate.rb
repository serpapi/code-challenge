require "json"

if ARGV.length != 2
  warn "Usage: ruby scripts/validate.rb <out.json> <expected-array.json>"
  exit 1
end

out_path, expected_path = ARGV
out = JSON.parse(File.read(out_path, encoding: "UTF-8"))
exp = JSON.parse(File.read(expected_path, encoding: "UTF-8"))

def keys_of_first(arr)
  arr.is_a?(Array) && arr.any? ? arr.first.keys.sort : []
end

ok_top = out.is_a?(Hash) && out["artworks"].is_a?(Array)
abort("❌ Output must be an object with an 'artworks' array.") unless ok_top

k_out = keys_of_first(out["artworks"])
k_exp = keys_of_first(exp["artworks"])

abort("❌ Key mismatch.\n out: #{k_out}\n exp: #{k_exp}") unless k_out == k_exp

abs_links = out["artworks"].all? { |h| h["link"].to_s.start_with?("http") }
abort("❌ Some links are not absolute URLs.") unless abs_links

puts "✅ Shape & basic checks passed."
