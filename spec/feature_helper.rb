require 'rails_helper'

require 'capybara/rspec'
require 'capybara/rails'

RSpec.configure do |config|
  config.include Capybara::DSL, :type => :api
end

Capybara.server_port = 9887

def json
  JSON.parse(page.body)
end