require 'ruby-prof'
require_relative 'parser'


html = File.read("files/van-gogh-paintings.html")

result = RubyProf::Profile.profile do
  1000.times { tokenize(html) }
end

printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT)
