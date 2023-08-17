# frozen_string_literal: true

require 'zeitwerk'

def setup_auto_loading
  loader = Zeitwerk::Loader.new
  loader.push_dir("#{__dir__}/../app")
  loader.setup
end
