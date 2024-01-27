require_relative 'boot'
require_relative 'lib/fetcher'
require_relative 'lib/parser'

require 'json'
class Run
  def self.run
    file =  File.expand_path(
      File.join(
        File.dirname(__FILE__), "files/van-gogh-paintings.html"
      )
    )

    html = Fetcher.new(file).rendered
    parser = Parser.new(html)

    JSON.pretty_generate(parser.to_serializable_hash)
  end
end


puts Run.run