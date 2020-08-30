FROM ruby:2.5.1
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    postgresql-client \
    vim \
    yarn


WORKDIR /ryo1-app
COPY Gemfile Gemfile.lock /ryo1-app/
RUN bundle install
ADD . /ryo1-app
RUN mkdir -p tmp/sockets

VOLUME /ryo1-app/public
VOLUME /ryo1-app/tmp