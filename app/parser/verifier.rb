# frozen_string_literal: true

require 'hashdiff'

module Parser
  # TODO: add unit spec
  class Verifier
    def initialize(data, expected)
      @data = data
      @expected = expected
    end

    def valid?
      case [@data, @expected]
      in Parser::Response(Hash => data), Hash # both parser' response and expected data are hashes
        calculate_diff(data, @expected)
      else
        false
      end
    end

    private

    def calculate_diff(payload, expected)
      diff = Hashdiff.diff(payload, expected)
      diff.empty?
    end
  end
end
