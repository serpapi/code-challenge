require_relative 'parsers/google'

parser = Parser::Google.new(ARGV[0])
parser.parse_carousel
parser.to_file
