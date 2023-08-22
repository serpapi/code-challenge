# frozen_string_literal: true

require 'hashdiff'

module Parser
  class Verifier
    # This class is needed to verify parser response and return diff for later investigation
    # It's better to schedule verification of each parser on daily basis to monitor layout changes

    Verification = Data.define(:valid?, :diff)
    Invalid = Data.define(:data)

    def initialize(data, expected)
      @data = data
      @expected = expected
    end

    def valid?
      case verify
      in Verification(valid?: true)
        true
      else
        false
      end
    end

    def verify
      case [@data, @expected]
      in Parser::Response(Hash => data), Hash # both parser' response and expected data are hashes
        calculate_diff(data, @expected)
      else
        Invalid.new(data)
      end
    end

    private

    def calculate_diff(payload, expected)
      case Hashdiff.diff(payload, expected)
      in []
        Verification.new(true, [])
      in diff
        Verification.new(false, diff)
      end
    end
  end
end
