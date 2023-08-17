# frozen_string_literal: true

Parser::Error = Data.define(:exception, :payload) do
  def initialize(exception:, payload: nil)
    super
  end
end
