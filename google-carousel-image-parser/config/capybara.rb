require 'capybara'

Capybara.configure do |config|
  config.default_driver = :selenium_chrome_headless
  config.enable_aria_label = true
  config.match = :first
  config.run_server = false
  config.threadsafe = true
  config.use_html5_parsing = true
end
