# frozen_string_literal: true

require './parser/artworks/google/base_worker'
require './parser/artworks/google/v1/worker'
require './parser/artworks/google/v2/worker'
require './parser/input/base'
require './parser/input/file'
require './parser/output/base'
require './parser/output/json'

require 'nokogiri'
require 'json'
