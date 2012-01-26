source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'devise'

gem 'client_side_validations'

# gem 'twitter'
# gem 'resque', :require => 'resque/server'
# gem 'delayed_job', '3.0.1'
gem 'delayed_job_active_record'
# gem "delayed_job_web"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :production do 
 gem 'pg'
 gem 'rack-google_analytics', :require => "rack/google_analytics"
 gem 'newrelic_rpm'
end
group :development do
 gem 'hirb'
 gem 'mysql2'
 gem 'rack-google_analytics', :require => "rack/google_analytics"
end

gem 'jquery-rails'
# gem 'jquery_datepicker'
gem 'asset_sync'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
