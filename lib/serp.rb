# frozen_string_literal: true

require 'rubygems'
require 'nokogiri'
require 'json'

Dir["#{__dir__}/parser/**/*.rb"].sort.each { |file| require file }
