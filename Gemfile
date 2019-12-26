source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.7'

gem 'rails', '~> 5.2.3'
gem 'puma', '~> 3.11'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'

gem 'devise'
gem 'jquery-rails'
gem 'jquery-ui-rails', '~> 5.0'
gem 'toastr-rails'

gem 'dotenv-rails'
gem 'faker'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'font-awesome-sass', '~> 5.4.1'

gem 'kaminari','~> 1.1.1'

gem "refile", require: "refile/rails", github: 'manfe/refile'
gem "refile-mini_magick"
gem 'cocoon'
gem 'omniauth'
gem 'omniauth-google-oauth2'

gem 'geocoder', '~> 1.4'
gem 'counter_culture', '~> 1.8'

gem 'ransack', github: 'activerecord-hackery/ransack'

gem 'stripe', '~> 3.0.0'
gem 'rails-assets-card', source: 'https://rails-assets.org'
gem 'chartkick', '~> 2.2.4'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener_web'
  gem 'bullet'
  gem 'pry-rails'
  gem 'pry-byebug'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
end

group :production do
  gem 'mysql2'
end



# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
