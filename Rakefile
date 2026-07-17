# frozen_string_literal: true

require "rake"
require "rspec/core/rake_task"
require "rubocop/rake_task"

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new(:rubocop)

desc "Run all quality checks"
task default: %i[spec rubocop]
