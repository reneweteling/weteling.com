source "https://rubygems.org"

gem "rails", "~> 6.1"
gem "pg"
gem "puma"
# Sass using the libC compiler, prefixer for css vendors.
gem "sass-rails", require: false
gem "sassc-rails"
gem "autoprefixer-rails"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier"
# Use jquery as the JavaScript library
gem "jquery-rails"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks"

# Handle javascript
gem "webpacker"

# Move our uploads to AWS
gem "carrierwave-aws"
# error reporting
gem "airbrake", "10.0.1"

gem "browser"
gem "redcarpet"

# Nice templates
gem "slim-rails"
gem "mini_magick"

# Sendgrid
gem "sendgrid-ruby"

# Activeadmin
gem "activeadmin"
gem "activeadmin_addons"
gem "activeadmin-sortable"
gem "acts_as_list"
gem "devise"
gem "country_select"
gem "cancancan"

# Pdfs
gem "pdfkit"

# Calender
gem "fullcalendar-rails"
gem "momentjs-rails"

# Forms
gem "simple_form"

# Assets
gem "font-awesome-sass"
gem "bootstrap", "~> 4.5"

# validations
gem "rails_validations"

source "https://rails-assets.org" do
  gem "rails-assets-editor.md"
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platform: :mri
  gem "pry"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem "web-console"
  gem "listen"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen"
  gem "graphiql-rails"
  # gems for VS-code plugins
  gem "solargraph"
  gem "prettier"
  gem "rubocop"
  gem "rubocop-rails"
  gem "rubocop-performance"
end
