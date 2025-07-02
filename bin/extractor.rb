require './lib/extractor'
require 'json'

def main
  if ARGV.empty?
    puts('Please provide the path to the Google search results page HTML file.')
    puts("\tUsage: ruby #{$PROGRAM_NAME} <path_to_serp_file>")
    puts("\tExample: ruby #{$PROGRAM_NAME} ./files/van-gogh-paintings.html")
    exit(1)
  end

  serp_path = ARGV[0]

  begin
    artworks = Extractor.extract_artworks_from_serp_file(serp_path)
    puts(JSON.pretty_generate({ artworks: artworks }))
  rescue StandardError => e
    puts("An error occurred while extracting artworks: #{e.message}")
    exit(1)
  end

end

if __FILE__ == $PROGRAM_NAME
  main
end