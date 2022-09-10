FROM ruby:3.1.2
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    default-mysql-client \
    yarn

WORKDIR /Piso
COPY Gemfile Gemfile.lock /Piso/
RUN bundle install