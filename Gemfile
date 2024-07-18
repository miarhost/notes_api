source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

gem "rails", "~> 7.0.8", ">= 7.0.8.4"
gem 'active_model_serializers'
gem "mysql2", "~> 0.5"
gem 'dotenv-rails'
gem 'faraday'
gem "puma", "~> 5.0"
gem 'kaminari'
gem "redis", "~> 4.0"
gem 'redis-namespace'
gem 'redis-rails'
gem 'redis-store'
gem 'sidekiq', '~> 7.1', '>= 7.1.2'
gem 'sidekiq-status'
gem 'whenever', require: false
gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "rack-cors"
gem 'mongo'
gem 'mongoid'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'faker'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.3'
  gem 'webmock'
end

group :test do
  gem 'shoulda-matchers'
  gem 'rspec-json_expectations'
end

group :development do
  gem "spring"
end
