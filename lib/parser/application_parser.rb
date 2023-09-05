module Parser
  class ApplicationParser
    def initialize(*); end

    def self.call(*args, &block)
      new(*args, &block).call
    end
  end
end