# frozen_string_literal: true

# defines an abstract service class to spare us from calling Object.new.call
module Services
  class AbstractService
    class << self
      def call(...)
        new(...).call
      end
    end
  end
end
