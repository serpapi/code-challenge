$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'
require 'pry_wrench'


RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.max_formatted_output_length = nil # Prevents rspec from truncating diffs
  end
end

