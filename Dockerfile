FROM ruby:2.6.5

RUN apt-get update -qq && apt-get install -y build-essential \
                                             libpq-dev && \
    apt-get clean -qq && \
    gem update --system && \
    gem install bundler

RUN mkdir -p /docker

RUN mkdir -p /usr/local/bundle
ENV BUNDLE_PATH=/usr/local/bundle

RUN mkdir -p /app
WORKDIR /app

COPY . /app

RUN cd /app && bundle install
