RSpec.configure do |config|
  config.expect_with :rspec do |c| c.syntax = :expect end
  config.mock_with :rspec do |m| m.verify_partial_doubles = true end
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!
  config.warnings = false
end
