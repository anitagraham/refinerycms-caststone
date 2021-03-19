source "http://rubygems.org"

gemspec

git "https://github.com/refinery/refinerycms", branch: "master" do
  gem "refinerycms"

  group :test do
    gem "refinerycms-testing"
  end
end

# vulnerability
gem "activesupport", ">= 6.0.3.1"


# gem "actionpack", ">= 6.0.3.2"  # CVE-2020-8185
# Refinery locked down to actionpack 6.0.3.1, use recommended action in config/environemnts/production.rb
# config.middleware.delete ActionDispatch::ActionableExceptions

gem 'responders'
gem 'simple_form'
gem 'refinerycms-acts-as-indexed', github: 'refinery/refinerycms-acts-as-indexed', branch: 'master'

group :development do
  gem 'listen'
end

group :test do
  gem 'capybara-email', '~> 3.0'
  gem 'poltergeist'
end

# Database Configuration
unless ENV['TRAVIS']
  gem 'activerecord-jdbcsqlite3-adapter', '>= 1.3.0.rc1', platform: :jruby
  gem 'sqlite3', platform: :ruby
end

if !ENV['TRAVIS'] || ENV['DB'] == 'mysql'
  gem 'activerecord-jdbcmysql-adapter', platform: :jruby
  gem 'jdbc-mysql', '= 5.1.13', platform: :jruby
  gem 'mysql2', platform: :ruby
end

if !ENV['TRAVIS'] || ENV['DB'] == 'postgresql'
  gem 'activerecord-jdbcpostgresql-adapter', platform: :jruby
  gem 'pg', platform: :ruby
end

# Load local gems according to Refinery developer preference.
if File.exist? local_gemfile = File.expand_path('../.gemfile', __FILE__)
  eval File.read(local_gemfile)
end
