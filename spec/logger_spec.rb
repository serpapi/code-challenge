# frozen_string_literal: true

require 'services/logger'

describe Services::Logger do
  describe :logger do
    let(:logger_instance) { Class.new(Services::Logger).instance }

    it 'posts a log entry' do
      stub_const('ENV', {}) # mock env
      expect { logger_instance.log(:error, 'TEST LOG MESSAGE') }.to output(/TEST LOG MESSAGE/).to_stderr
    end
  end
end
