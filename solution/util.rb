# Miscellaneous utility functions useful during development.

def dump_html_to_file(html:, filename:, beautify: false)
  File.write(filename, beautify ? HtmlBeautifier.beautify(html) : html)
end

def dump_hash(h, shorten_long_strings: true)
  puts '--------------------------------------------------------------------------------'
  h.each do |k,v| 
    s = shorten_long_strings ? head_tail_string(v) : v
    puts "#{k}: #{s}"
  end
end

def head_tail_string(s, show_n_chars: 31)
  return nil unless s.is_a?(String)
  return s if s.length <= show_n_chars || show_n_chars.nil?
  s[0..10] + '...' + s[-10..] + " >> #{s.length} total length"
end

def reload!
  # For interactive REPL debugging
  root_path = File.expand_path(File.dirname(__FILE__))
  dirs = %w[lib]
  puts "Reloading sources in #{root_path}/[#{dirs.join(', ')}]..."
  files = dirs.map { |d| Dir.glob("#{root_path}/#{d}/**/*.rb") }.flatten
  files.append(__FILE__) # reload this file too!
  files.each { |f| load(f) && puts(f) }
  nil
end
