require_relative "./challenge/challenge.rb"

fname = 'files/van-gogh-paintings.html'

document = Challenge::HtmlFileParser.new(fname).parse
result = Challenge::Parser.new(document).parse

pp result
