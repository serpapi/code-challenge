.PHONY: examples install benchmark test


install:
	@echo "Installing dependencies..."
	@sudo bundle install

benchmark:
	@echo "\Benchmarking ..."
	@ruby benchmark.rb

examples:
	@echo "\Producing examples ..."
	@ruby examples.rb

test:
	@echo "\Testing parser ..."
	@rspec spec/*_spec.rb
