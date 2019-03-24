FROM ruby:2.6.1

ENV LANG C.UTF-8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN gem install bundler

# yarnパッケージ管理ツールインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - && \
  apt-get install nodejs

RUN mkdir /diclog
WORKDIR /diclog
ADD Gemfile /diclog/Gemfile
ADD Gemfile.lock /diclog/Gemfile.lock
COPY . /diclog
RUN yarn install && gem update bundler && bundle install