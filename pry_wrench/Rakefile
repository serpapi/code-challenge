# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose = false
end

RSpec::Core::RakeTask.new(:integration) do |t|
  t.verbose = false
  t.pattern = "spec/**/*_int.rb"
end

# this is for running tests that you've marked current... eg: it 'should work', :current => true do
# I waffle between this work flow and the one defined in spec_helper.rb which uses focus: true
# which overrides the entire test suite... not better
RSpec::Core::RakeTask.new(:current) do |t|
  t.verbose = false
  t.pattern = 'spec/**/*_{spec,int}.rb'
  t.rspec_opts = ['--tag current']
end

# alias for current
RSpec::Core::RakeTask.new(:c) do |t|
  t.verbose = false
  t.pattern = 'spec/**/*_{spec,int}.rb'
  t.rspec_opts = ['--tag current']
end

task default: :spec
