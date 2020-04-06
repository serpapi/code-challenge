# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem "nokogiri"
gem "sorbet-runtime"

group :development do
  gem "sorbet"
  # Uncomment below before running bundle exec srb init/update
  gem 'webrobots'
  gem 'rake'
  gem 'html_truncator'
end

group :test do
  gem "rspec"
  gem 'simplecov', require: false
end
