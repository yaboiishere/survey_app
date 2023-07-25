FROM ruby:3.1.4

WORKDIR /app

COPY Gemfile Gemfile.lock /app

RUN bundle install


