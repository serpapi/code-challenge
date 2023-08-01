module Parsers
  class Base
    attr_reader :document

    def initialize(file_path:)
      contents = File.read(file_path)
      @document = Nokogiri::HTML(document)
    rescue Errno::ENOENT
      raise MissingFileError, "Missing file in the following path: #{file_path}"
    end
  end
end