# Dockerfile
FROM ruby:2.7-alpine

WORKDIR /var/www/html

# throw errors if Gemfile has been modified since Gemfile.lock
RUN gem install bundler:2.1.4
RUN bundle config --global frozen 1

# Bundle in seperate layer
RUN bundle config build.nokogiri --use-system-libraries

RUN apk add --update \
    bash \
    build-base \
    gcompat \
    imagemagick \
    libxml2-dev \
    libxslt-dev \
    postgresql-dev \
    tzdata \
    wkhtmltopdf

RUN apk add --virtual .build-deps \
    nodejs \
    yarn

COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install --jobs=4 --retry=3

# Copy all files
COPY . .
RUN yarn
RUN bundle exec rails assets:precompile
    
# Cleanup    
RUN apk del .build-deps
RUN rm -rf /var/cache/apk/*
RUN rm -rf /var/www/html/nodejs

# Go!
EXPOSE 5000
