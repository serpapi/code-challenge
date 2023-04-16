# frozen_string_literal: true

require 'rake'
require 'rspec/core/rake_task'
require_relative './lib/vangogh'

INFILE = './files/van-gogh-paintings.html'
OUTFILE = './output.json'
EXPECTED_RESULTS = './files/expected-array.json'

task :default => :all

desc 'Runs the parser on the provided html file, saving results to output.json'
task :generate do

  puts "Parsing file at #{INFILE} and writing results to #{OUTFILE}"
  Parser.execute!(INFILE, OUTFILE)
end

desc 'Compares the generated output to the expected output'
task :compare do
  unless File.exists?(OUTFILE)
    puts "Cannot compare without generating the file first"
    return
  end

  # expected results file is not properly formatted json
  # because it lacks enclosing braces
  expected = JSON.parse( "{#{File.read(EXPECTED_RESULTS)}}")
  actual   = JSON.parse(File.read(OUTFILE))

  if expected == actual
    puts 'Generated file matches provided output'
  else
    puts 'Generated file does not match provided output'
  end
end

desc 'Removes the generated results'
task :clean do
  puts "Deleting generated file at #{OUTFILE}"
  File.delete(OUTFILE) if File.exists?(OUTFILE)
end

RSpec::Core::RakeTask.new(:spec)

task :all => [:clean, :generate, :compare]