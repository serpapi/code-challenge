require 'nokogiri'
require 'rspec'

# Loads all classes and modules in /app dir
Dir['./app/**/*.rb'].each { |file| require file }

module Application
  class Error < StandardError; end
end