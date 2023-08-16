# frozen_string_literal: true

# defines an abstract service class to spare us from calling Object.new.call
module Services
  # basic service class to be inherited from all services
  class AbstractService
    class << self
      def call(...)
        new(...).call
      end
    end
  end
end
