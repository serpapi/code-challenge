# frozen_string_literal: true

require 'json'
require_relative 'modules/knowledge_panel_carousel_parser'

path = ARGV[0] or abort 'usage: ruby use_knowledge_panel_carousel_parser.rb path/to/filename.html'
html = File.read(path)

kp_parser = KnowledgePanelCarouselParser.new

puts JSON.pretty_generate(JSON.parse(kp_parser.parse(html)))
