def next?
  File.basename(__FILE__) == "Gemfile.next"
end
source "https://rubygems.org"
ruby "3.3.6"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2"
gem "propshaft"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
gem "dotenv-rails"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "tailwindcss-rails"
# Build JSON APIs with ease [https://github.com/amatsuda/jb]
gem "jb"
# Use Redis adapter to run Action Cable in production
gem "redis", "~> 5.3"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false
  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop", require: false
  gem "rubocop-rails-omakase", require: false
  gem "minitest-reporters"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem "bullet", "~> 8.0"
  gem "erb-formatter"
  gem "annotaterb"
  gem "lookbook", ">= 2.3.4"
  gem "listen"
  gem "hotwire-spark"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "database_cleaner-active_record"
  gem "capybara"
  gem "selenium-webdriver"
  gem "mutex_m"
  gem "simplecov", require: false
  gem "minitest-rails"
end

gem "devise", "~> 4.9"

# full text search with PostgreSQL
gem "pg_search"

# adds tagging functionality to your models
gem "acts-as-taggable-on"

# More modern way to compose HTML views
gem "view_component"

# pagination
gem "pagy", "~> 9.3"

# permissions management
gem "pundit", "~> 2.5"

# active storage validations
gem "activestorage-validator"

gem "sidekiq", "~> 8.0"

gem "json-schema"

gem "csv", "~> 3.3"
gem "aws-sdk-s3", "1.170", require: false
gem "aws-sdk-core", "3.226.0"
gem "faker"

gem "honeybadger", "~> 5.28"

gem "solid_cache", "~> 1.0"
