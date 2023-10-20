# frozen_string_literal: true

module Parser
  module Input
    class File < Parser::Input::Base
      def read
        ::File.open(parameter).read
      end
    end
  end
end
