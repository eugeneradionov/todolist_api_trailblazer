source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'acts_as_list', '~> 0.9.16'
gem 'apipie-rails', '~> 0.5.10'
gem 'devise_token_auth', '~> 0.2.0'
gem 'dotenv-rails', '~> 2.5'
gem 'fast_jsonapi', '~> 1.4'
gem 'omniauth', '~> 1.8', '>= 1.8.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rack-cors', '~> 1.0', '>= 1.0.2'
gem 'rails', '~> 5.2.1'
gem 'reform-rails', '~> 0.1.7'
gem 'trailblazer-rails', '~> 2.1', '>= 2.1.5'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'capybara', '~> 3.7', '>= 3.7.1'
  gem 'database_cleaner', '~> 1.7'
  gem 'factory_bot_rails', '~> 4.11', '>= 4.11.1'
  gem 'ffaker', '~> 2.10'
  gem 'fuubar', '~> 2.3', '>= 2.3.2'
  gem 'json_matchers', '~> 0.10.0'
  gem 'pry-byebug', '~> 3.6'
  gem 'rspec-rails', '~> 3.8'
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers', branch: 'rails-5'
  gem 'transactional_capybara', '~> 0.2.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
