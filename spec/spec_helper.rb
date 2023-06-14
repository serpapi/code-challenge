require_relative '../app'

ENV["RACK_ENV"] = "test"

module SinatraApp
  def app() App end
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include SinatraApp
end
