source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.1.0'
gem 'pg', '~> 1.2', '>= 1.2.3'
gem 'puma', '~> 5.0'
gem 'pagy'
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'rspec-rails', '~> 4.0.1'

  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'database_cleaner-active_record'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
