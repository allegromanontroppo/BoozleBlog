source 'http://rubygems.org'

gem "rake", "~> 0.9.2"
gem "rack", "~> 1.3.3"
gem "rails", "~> 3.1.0"
gem "haml", "~> 3.1.3"
gem "rails_autolink", "~> 1.0.2"
gem "devise", "~> 1.4.7"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.1.0"
 # gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails', '1.0.14'

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
end
