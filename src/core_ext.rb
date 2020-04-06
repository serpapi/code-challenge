# typed: strong
# frozen_string_literal: true

require "sorbet-runtime"

class String
  extend T::Sig

  sig { returns(T.nilable(String)) }
  def not_empty
    self == "" ? nil : self
  end
end
