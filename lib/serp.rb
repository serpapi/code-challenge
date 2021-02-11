# frozen_string_literal: true

require 'pathname'

##
# Module declaration to set basic ENV and constants
module SERP
  PROJECT_ROOT = File.expand_path(Pathname.new(__FILE__).join('../..'))
  DEBUG = ENV['SERP_DEBUG'] && !ENV['SERP_DEBUG'].empty? ? ENV['SERP_DEBUG'].to_i : false
  VERSION = '0.0.1'
  NAME = 'serpcrawler'
end

if SERP::DEBUG&.zero?
  require_relative './utils/tapp_amazing_print'
  require 'byebug'
end
