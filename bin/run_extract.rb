require_relative "../lib/extract"

if __FILE__ == $0
	html = File.open(ARGV[0]).read
	output = extract(html)

	puts output

	if ARGV.length > 1 # validate against this file
		expected_file = File.read(ARGV[1])
		expected = (JSON.parse(expected_file))["artworks"]
		if true
			output.zip(expected).each do |output_artwork, expected_artwork|
				if output_artwork != expected_artwork
					puts "Output: "
					puts output_artwork
		
					puts "Expected:"
					puts expected_artwork
				end
			end
		end
	end
end
