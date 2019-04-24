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
    && rm -rf /var/cache/apk/*
COPY Gemfile Gemfile.lock ./
RUN bundle check --path=vendor/bundle || bundle install --jobs=4 --retry=3 --path vendor/bundle

# Copy all files
COPY . .

# Start server
CMD ["bundle exec puma -C config/puma.rb"]