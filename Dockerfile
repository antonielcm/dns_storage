FROM ruby:2.7.2-alpine3.12

RUN apk add --no-cache --update build-base \
    linux-headers \
    postgresql-dev \
    nodejs \
    tzdata

ENV APP_PATH /usr/src/app
WORKDIR $APP_PATH

ADD Gemfile $APP_PATH
ADD Gemfile.lock $APP_PATH
RUN gem list bundler
RUN gem install bundler -v 2.0.2
RUN gem list bundler
RUN bundle install

COPY . APP_PATH
EXPOSE 3000