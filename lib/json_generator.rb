# frozen_string_literal: true

module SERP
  class JSONGenerator
    def self.generate(data:, pretty: false)
      return Oj.dump(data) unless pretty

      require 'neatjson'
      opts = {
        short: false, wrap: 60, decimals: 3, sort: false, aligned: false,
        padding: 1, after_comma: 1, after_colon_n: 1
      }

      JSON.neat_generate(data, opts)
    end
  end
end
