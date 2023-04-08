# list_fixtures.rb
require 'find'

dir_path = 'spec/fixtures'

puts "Content of the '#{dir_path}' directory:"

Find.find(dir_path) do |path|
  if FileTest.directory?(path)
    next
  else
    puts path
  end
end
