FROM ruby:2.6.4

RUN mkdir -p /app
WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle install

RUN bundle exec rspec spec
