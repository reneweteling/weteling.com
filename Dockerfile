# Dockerfile
FROM ruby:3.2

WORKDIR /app

ARG RAILS_ENV=production
ENV RAILS_ENV=$RAILS_ENV
ENV NODE_ENV=production
ENV RUBY_CONFIGURE_OPTS=--enable-yjit
ENV RUBY_YJIT_ENABLE=true
ENV DEBIAN_FRONTEND=noninteractive

# ENV NODE_OPTIONS=--openssl-legacy-providerbin
# Bundle in seperate layer
RUN bundle config build.nokogiri --use-system-libraries

ENV NODE_MAJOR=20
RUN echo "deb [trusted=yes] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN echo "deb [trusted=yes] https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && \
    apt-get install -y \
    bash \
    gcc \
    g++ \
    make \
    imagemagick \
    libxml2-dev \
    libxslt-dev \
    libpq-dev \
    tzdata \
    nodejs \
    yarn \
    wkhtmltopdf

RUN groupadd --gid 1000 dev
RUN useradd --uid 1000 --gid dev --shell /bin/bash --create-home dev
RUN chown -R dev:dev /app

USER dev

RUN gem install bundler:2.4.13

# Install ruby packages
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs=4 --retry=3

# # Install node packages
COPY package.json yarn.lock ./
RUN yarn
RUN yarn global add webpack-dev-server

# Copy all files
COPY . .

# need to place the files in the forlders in the app.json
# RUN bin/rails assets:precompile
# RUN mv ./public/assets ./public/tmp_assets && mv ./public/packs ./public/tmp_packs

# Go!
EXPOSE 5000
