# coding: utf-8
require_relative 'lib/pry_wrench/version'

version = PryWrench::VERSION

Gem::Specification.new do |s|
  s.name          = "pry_wrench"
  s.version       = version
  s.authors       = ["TheNotary"]
  s.email         = ["no@email.plz"]

  s.summary       = %q{A gem}

  s.homepage      = "https://github.com/TheNotary/pry_wrench"
  s.required_ruby_version = ">= 3.0.0"

  s.metadata["allowed_push_host"] = "https://localhost.com" # prevents accidental gem pushes for private projects

  s.metadata["homepage_uri"] = s.homepage
  s.metadata["source_code_uri"] =  s.homepage
  s.metadata["changelog_uri"] =  s.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  s.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .gitlab-ci.yml appveyor Gemfile])
    end
  end
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  # s.add_dependency "bundler", "~> 2.6"

  s.add_development_dependency "bundler", "~> 2.6"
  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency "rspec"
  s.add_development_dependency "pry"
end
