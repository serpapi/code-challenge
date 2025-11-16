# PryWrench

TODO: Describe your gem/ CLI tool


## Installation

To install this from source, just run

    $ rake install


## Usage

As a cli, run `pry_wrench`


## Development

Install dependencies with...

    $ bundle

Mark individual tests with `, current: true` and run them with...

    $ rake c

Run the entire unit test suite with...

    $ rake

Run the integration test suite with...

    $ rake integration


### Development Notes

If a CLI is being developed, see `exe/pry_wrench` and consider adopting Thor or its alternatives if this will be a heavy CLI tool.

For open source projects, releasing a new version is done with an update to the version number in `version.rb`.  Then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).  By default you'll need to tweak the gemspec file in root to enable pushes.
