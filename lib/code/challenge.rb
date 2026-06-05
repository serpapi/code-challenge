require_relative "challenge/version"
require_relative "challenge/webpage_parser"

module Code
  module Challenge
    class Error < StandardError; end

    def self.parse_webpage(html)
      WebpageParser.parse(html)
    end
  end
end
