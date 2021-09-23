# Dockerfile
FROM ruby:3.0-alpine

WORKDIR /var/www/html

ENV RAILS_ENV=production
ENV RACK_ENV=production
ENV NODE_ENV=production
ENV BUNDLE_PATH=/var/www/bundler
ENV GEM_HOME=/var/www/gems

# throw errors if Gemfile has been modified since Gemfile.lock
# RUN gem install bundler:2.2.27
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
    nodejs \
    wkhtmltopdf \
    yarn

COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install --jobs=4 --retry=3

# Copy all files
COPY . .
RUN yarn

# need to place the files in the forlders in the app.json
RUN bundle exec rails assets:precompile
RUN mv ./public/assets ./public/tmp_assets && mv ./public/packs ./public/tmp_packs
    
# Go!
EXPOSE 5000
