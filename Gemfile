source 'https://rubygems.org'

ruby '3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.3'
# Use Puma as the app server
gem 'puma', '~> 5.6'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

#scrapper
gem 'mechanize', '~> 2.8.4'

#for serialization
gem 'active_model_serializers', '~> 0.10.13'

# worker
gem 'sidekiq', github: 'mperham/sidekiq' # TODO: revert to version, https://github.com/mperham/sidekiq/issues/5178#issuecomment-1029545859

group :development, :test do
  gem 'pry-rails'
  gem 'shoulda-matchers', '~> 5.1'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'webmock', '~> 3.14'
  gem 'vcr'
end

group :development do
  gem 'listen', '~> 3.7'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
