# frozen_string_literal: true

require 'uri'

RSpec::Matchers.define :be_a_url do |_expected|
  match do |actual|
    actual =~ URI::DEFAULT_PARSER.make_regexp
  end
end

RSpec::Matchers.alias_matcher :a_url, :be_a_url
