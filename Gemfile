source 'http://rubygems.org'

gem "rails", "~> 3.2.14"
gem "rake"
gem "rack"
gem "haml"
gem "rails_autolink", "~> 1.0.2"
gem "devise"

gem 'jquery-rails'
gem 'will_paginate'

# Gems used only for assets and not required
# in production environments by default.nil
group :assets do
  gem "sass-rails"
  gem 'compass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

gem "rdiscount", "~> 1.6.8"
gem 'will_paginate-foundation'
# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :production do
  gem 'execjs'
  gem 'therubyracer'
  #gem 'mysql2'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

group :development, :test do
  gem 'sqlite3'
  gem "annotate", "~> 2.4.0"
end
