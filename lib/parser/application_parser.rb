require 'nokogiri'
require 'uri'
require 'json'

module Parser
  class ApplicationParser
    BASE64_PREFIX = 'data:image/jpeg'.freeze

    def initialize(*); end

    def self.call(*args, &block)
      new(*args, &block).call
    end

    private

    def read_file
      File.read(self.class::FILE_PATH)
    rescue Errno::ENOENT
      raise "Couldn't find a file at path: #{self.class::FILE_PATH}. Please, create it and try again."
    end

    def parse_file
      Nokogiri::HTML(file)
    rescue Nokogiri::SyntaxError
      raise "The HTML file at path: #{self.class::FILE_PATH} is invalid. Please, check it and try again."
    end
  end
end