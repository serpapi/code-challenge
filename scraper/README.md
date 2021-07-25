
# Scraper

A minified scraper for local HTML documents.

**`Scraper`** is built with ruby, nokogiri, byebug, rspec-rails and lots love :heart: :sparkling_heart:.

Because of our believe in being progressive, this is considered a work in progress :construction:. So, feel free to explore :ringed_planet:, thank you friend.

## Table of contents

- [Project Title](#scraper)

- [Table of contents](#table-of-contents)

- [Getting started](#getting-started)

- [Prerequisites](#prerequisites)

- [Project structure](#project-structure)

- [Project setup](#project-setup)
  - [Install all packages, plugins and dependencies](#install-all-packages,-plugins-and-dependencies)
  - [Run your app](#run-your-app)
  - [Run your unit tests](#run-your-unit-tests)
  - [How to use / About the App](#how-to-use-/-about-the-app)

- [Built with](#built-with)

- [Authors](#authors)

- [License](#license)

- [Contributing](#contributing)

- [Acknowledgments](#acknowledgments)

[(Back to top)](#scraper)

## Project structure

The following is a description of the folders in this project, and how they are used. Our Application Stack is ruby ("in vanilla").

**Application Source** Ruby Files:

- **`files`**: Challenge resources

- **`scraper`**: Main application resources
  - **`results`**: Results folder
  - **`tests`**: Tests folder
  - **`app.rb`**: Application main file

**Third Party Content** _( !.gitignored )_:

- **`Gemfile`**: Third Party Libraries installed via `Gemfile` during `bundle install`

[(Back to top)](#scraper)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

[(Back to top)](#scraper)

## Prerequisites

The things you will need in order to use the app and how to install them

- Before you begin, ensure you have the latest node installed on your computer - [Ruby 2.7.0](https://www.ruby-lang.org/en/downloads/) was used for this

Check with:

```bash
# ensure Ruby is >= 2.7.0
ruby --version
```

- Ruby 2.7.0 was used for this

[(Back to top)](#scraper)

## Project setup

This will walk you through how to setup the app on your local computer and/or machine.

### Install all packages, plugins and dependencies

- Navigate into "scraper" folder to be in the main application root folder.

```bash
bundle install
```

### Run your app

- Navigate into "scraper" folder to be in the main application root folder.

```bash
ruby app.rb
```

### Run your unit tests

- Navigate into "test" folder __(preferably)__

```bash
ruby app_test.rb
```

- Or run directly from "scraper" folder using __(discouraged)__

```bash
ruby tests/app_test.rb
```

### How to use / About the App

The scraper app is a minified data scraping app, designed to scrap data from a local HTML document. You need to have a copy of the project on your compter and/or your mchine to use. Visit [scraper repo] to clone, fork or download.

To use, follow steps in [Run your app](#run-your-app).

[(Back to top)](#scraper)

## Built with

- [Ruby](https://www.ruby-lang.org/en/) - An interpreted, high-level, general-purpose programming language

- [JSON](https://ruby-doc.org/stdlib-3.0.1/libdoc/json/rdoc/JSON.html) - Ruby built-in JSON module, to make JSON available in your code

- External libraries used in this project includes:

  - [nokogiri](https://nokogiri.org/) - Makes it easy and painless to work with XML and HTML from Ruby

  - [byebug](https://github.com/deivid-rodriguez/byebug) - A simple to use and feature rich debugger for Ruby

  - [rspec-rails](https://github.com/rspec/rspec-rails) - Helps in testing Ruby applications

[(Back to top)](#scraper)

## Authors

- **Mubarak SULAYMAN** - [@mubaraksulayman](https://twitter.com/mubaraksulayman)

See also the list of [contributors](https://github.com/MubarakSULAYMAN/newsman/contributors) who participated in this project.

[(Back to top)](#scraper)

## License

This project is licensed under the [MIT License](https://choosealicense.com/licenses/mit/).

[(Back to top)](#scraper)

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

[(Back to top)](#scraper)

## Acknowledgments

<!-- - Hat tip to contributors on stackoverflow, github gist and vue forum -->
- Inspiration was drawn from [serpapi/code-challenge] on github

[(Back to top)](#scraper)

[scraper repo]: https://github.com/MubarakSULAYMAN/code-challenge

[serpapi/code-challenge]: https://github.com/serpapi/code-challenge
