# Dockerfile
FROM ruby:2.6-alpine

WORKDIR /var/www/html

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

# Bundle in seperate layer
RUN bundle config build.nokogiri --use-system-libraries
RUN apk add --update \
    wkhtmltopdf \
    build-base \
    libxml2-dev \
    libxslt-dev \
    postgresql-dev \
    nodejs \
    tzdata \
    bash \
    vim \
    && rm -rf /var/cache/apk/*
COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install --jobs=4 --retry=3
EXPOSE 5000

RUN printenv

# Copy all files
COPY . .

# ARG RAILS_ENV=production
# ARG RACK_ENV=production

RUN bundle exec rails assets:precompile