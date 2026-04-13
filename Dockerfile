# Dockerfile
FROM ruby:3.2

WORKDIR /app

ARG RAILS_ENV=production
ENV RAILS_ENV=$RAILS_ENV
ENV NODE_ENV=production
ENV RUBY_CONFIGURE_OPTS=--enable-yjit
ENV RUBY_YJIT_ENABLE=true
ENV DEBIAN_FRONTEND=noninteractive

ENV NODE_OPTIONS=--openssl-legacy-provider
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
    wget \
    # Chromium dependencies for Grover/Puppeteer PDF generation
    chromium \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    fontconfig \
    libfreetype6 \
    && rm -rf /var/lib/apt/lists/*

# Tell Puppeteer to use system Chromium instead of downloading its own
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV GROVER_NO_SANDBOX=true

RUN gem install bundler:2.4.22

# Install ruby packages
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs=4 --retry=3

# Install node packages
COPY package.json yarn.lock ./
RUN yarn

# Copy all files
COPY . .

# Go!
EXPOSE 5000
