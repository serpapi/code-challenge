# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'web_lens'
  s.version     = '0.0.1'
  s.summary     = 'Web Lens :)'
  s.description = 'A parser for saved Google search HTML files.'
  s.authors     = ['Ruy Rocha']
  s.email       = 'admin@ruyrocha.com'
  s.files       = ['web_lens.rb']
  s.homepage    = ''
  s.license = 'MIT'
  s.add_dependency 'httpx'
  s.add_dependency 'nokogiri'

  s.add_development_dependency 'debug'
  s.add_development_dependency 'rspec'

  s.required_ruby_version = '>= 3.2'
end
