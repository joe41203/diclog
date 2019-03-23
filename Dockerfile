FROM ruby:2.6.1

ENV LANG C.UTF-8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN gem install bundler

RUN mkdir /diclog
WORKDIR /diclog
ADD Gemfile /diclog/Gemfile
ADD Gemfile.lock /diclog/Gemfile.lock
RUN bundle install
COPY . /diclog