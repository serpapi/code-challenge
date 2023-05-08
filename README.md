## Running instructions
This Ruby project uses Ruby version `3.2.1`.

After cloning this repo, run the following command to install the required dependencies:
```
bundle install
```
To run tests:
```
rspec
```
To run standard linter check:
```
standardrb
```

To get a JSON with scraped data from Van Gogh paintings HTML file, call the runner like this:
```
ruby runner.rb
```

To get a JSON from another HTML file, add an inline parameter with the file path
```
ruby runner.rb "./files/modern-painters.html"
```
