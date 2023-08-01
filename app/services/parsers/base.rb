module Parsers
  class Base
    attr_reader :document

    def initialize(file_path:)
      @document = File.open(file_path) { |f| Nokogiri::HTML(f) }
    rescue Errno::ENOENT
      raise MissingFileError, "Missing file in the following path: #{file_path}"
    end
  end
end