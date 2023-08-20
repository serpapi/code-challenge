# frozen_string_literal: true

require 'singleton'
require 'logger'
module Services
  # re-usable logger abstracted as a singleton
  class Logger
    include Singleton

    def initialize
      # Normally in a production environment, we would log to something different, e.g. use the rails logger,
      # but since we are in a simple ruby script for the sake of sanity :D ... we will be logging to a file.
      # Furthermore, we don't want to see log output during the run of our test suite.
      # See Rspec.configure for further information.
      log_level = ENV.fetch('RUBY_LOG_LEVEL', 'INFO')
      log_output = ENV.fetch('RUBY_LOG_OUTPUT', $stderr)

      return unless logger_enabled?

      @logger = ::Logger.new(log_output)
      @logger.level = ::Logger.const_get(log_level)
    end

    def log(severity, message)
      @logger.public_send(severity, message) if logger_enabled?
    end

    private

    # Per default, the logger is always enabled. If you want to disable it,
    # you can just set the ENV variable below to 0.
    def logger_enabled?
      ENV.fetch('RUBY_LOGGER_ENABLED', 1) == 1
    end
  end
end
