# frozen_string_literal: true

module Parser
  module Input
    class Base
      def initialize(parameter)
        @parameter = parameter
      end

      def read
        raise NotImplemented
      end

      private

      attr_reader :parameter
    end
  end
end
