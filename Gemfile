source 'https://rubygems.org'
ruby '2.4.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1'
# storage
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Sass using the libC compiler, prefixer for css vendors.
gem "sass-rails", require: false
gem "sassc-rails"
gem "autoprefixer-rails"
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# cache store
gem 'redis-rails'
# Move our uploads to AWS
gem 'carrierwave-aws'
# error reporting
gem 'airbrake', '~> 6.2'

gem 'browser'


# Nice templates
gem 'slim-rails', '3.1.1' # froze at this versino, issue with ckeditor
gem 'ckeditor'
gem 'mini_magick'

# Graphql
gem 'graphql'
gem 'graphql-batch'

# Activeadmin
gem 'activeadmin'
gem 'activeadmin_addons'
gem 'activeadmin-sortable'
gem 'acts_as_list'
gem 'devise'
gem 'country_select'
gem 'cancancan', '~> 2.0'

# Pdfs
gem 'pdfkit'

# Forms
gem 'simple_form'

# Assets
gem 'font-awesome-sass', '~> 4.7.0'
gem 'bootstrap', '~> 4.0.0.beta'

# validations
gem 'rails_validations', '~> 1.2'

source 'https://rails-assets.org' do
  gem 'rails-assets-stellar'
  gem 'rails-assets-jquery-migrate'
  gem 'rails-assets-waypoints'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'pry'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # capistrano
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano-passenger'

  gem 'graphiql-rails'
end