# Dockerfile
FROM surnet/alpine-wkhtmltopdf:3.16.2-0.12.6-full as wkhtmltopdf
FROM ruby:3-alpine as app

WORKDIR /var/www/html

ARG RAILS_ENV=production
ENV RAILS_ENV=$RAILS_ENV
ENV NODE_ENV=production

# throw errors if Gemfile has been modified since Gemfile.lock
RUN gem install bundler:2.2.27
RUN bundle config --global frozen 1

# Bundle in seperate layer
RUN bundle config build.nokogiri --use-system-libraries

RUN apk add --update --no-cache \
    bash \
    build-base \
    gcompat \
    imagemagick \
    libxml2-dev \
    libxslt-dev \
    postgresql-dev \
    tzdata \
    nodejs \
    npm \
    ttf-liberation 

RUN npm install --global yarn

COPY --from=wkhtmltopdf /bin/wkhtmltopdf /bin/libwkhtmltox.so /bin/

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs=4 --retry=3

# Install node packages
COPY package.json yarn.lock ./
RUN yarn

# Copy all files
COPY . .

# need to place the files in the forlders in the app.json
# RUN bin/rails assets:precompile
# RUN mv ./public/assets ./public/tmp_assets && mv ./public/packs ./public/tmp_packs
    
# Go!
EXPOSE 5000
