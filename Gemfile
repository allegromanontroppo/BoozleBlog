source 'http://rubygems.org'

gem "rails", "~> 3.1.3"
gem "rake", "~> 0.9.2.2"
gem "rack", "~> 1.3.5"
gem "haml", "~> 3.1.4"
gem "rails_autolink", "~> 1.0.2"
gem "devise", "~> 1.4.9"

# Gems used only for assets and not required
# in production environments by default.nil
group :assets do
  gem "sass-rails", "~> 3.1.5"
 # gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails', '1.0.14'
gem "rdiscount", "~> 1.6.8"
# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :production do
  gem 'execjs'
  gem 'therubyracer'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

group :development, :test do
  gem 'sqlite3'
  gem "annotate", "~> 2.4.0"
end
