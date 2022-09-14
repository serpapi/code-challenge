#!/usr/bin/env ruby

require_relative 'app/extract_items'

html_file = File.open(ARGV[0], 'r')

pp "Building HTML document"
service = ExtractItems.new(html_file: html_file, root_node_name: ARGV[1])
pp "Building HTML document: Finished"

pp "Extracting Knowledge Items data"
service.run
pp "Extracting Knowledge Items data: Finished"

pp "Extraction finished!"
pp "JSON Output file generated at: #{service.output_file_path}"