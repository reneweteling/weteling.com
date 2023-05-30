# Dockerfile
FROM ruby:3.1

WORKDIR /app

ARG RAILS_ENV=production
ENV RAILS_ENV=$RAILS_ENV
ENV NODE_ENV=production

# Bundle in seperate layer
RUN bundle config build.nokogiri --use-system-libraries

RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

RUN apt-get install -y \
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

# throw errors if Gemfile has been modified since Gemfile.lock
RUN gem install bundler:2.4.13
RUN bundle config --global frozen 1


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
