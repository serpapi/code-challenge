# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

gem 'nokogiri', '~> 1.15', '>= 1.15.3'
gem 'rake'

group :development do
  gem 'overcommit', '~> 0.60.0'
  gem 'rubocop', require: false
end

group :test do
  gem 'rspec', '~> 3.12'
end
