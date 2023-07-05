# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rspec'

RSpec.configure do |config|
  # Use color in STDOUT.
  config.color = true

  # Use color not only in STDOUT but also in pagers and files.
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation

  # Enables the new `:expect` syntax.
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
