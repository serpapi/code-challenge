$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "nokolexbor"

RSpec.configure do |config|
  unless config.files_to_run.one?
    require "simplecov"

    SimpleCov.start do
      track_files "lib/**/*.rb"
      enable_coverage :branch
      add_group "Lib", "lib"
      add_filter "/spec/"
    end
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.order = :random
  Kernel.srand config.seed

  config.default_formatter = "doc" if config.files_to_run.one?
end
