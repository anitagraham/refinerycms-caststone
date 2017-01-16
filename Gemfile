source "http://rubygems.org"

gemspec

gem 'refinerycms'
gem 'refinerycms-wymeditor'

gem 'quiet_assets'
gem 'spring'
gem 'spring-commands-rspec'
gem 'poltergeist', '>= 1.8.1'

gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'

group :test do
  gem 'refinerycms-testing'
  gem 'generator_spec', '~> 0.9.3'
  gem 'launchy'
  gem 'coveralls', require: false
  gem 'rspec-retry'
end

require 'rbconfig'

platforms :jruby do
  gem 'activerecord-jdbcsqlite3-adapter'
  gem 'activerecord-jdbcmysql-adapter'
  gem 'activerecord-jdbcpostgresql-adapter'
  gem 'jruby-openssl'
end

unless defined?(JRUBY_VERSION)
  gem 'sqlite3'
  gem 'mysql2'
  gem 'pg'
end

platforms :mswin, :mingw do
  gem 'win32console'
  gem 'rb-fchange', '~> 0.0.5'
  gem 'rb-notifu', '~> 0.0.4'
end

platforms :ruby do
  gem 'spork', '0.9.0.rc9'
  gem 'guard-spork'

  unless ENV['TRAVIS']
    if RbConfig::CONFIG['target_os'] =~ /darwin/i
      gem 'rb-fsevent', '>= 0.3.9'
      gem 'growl',      '~> 1.0.3'
    end
    if RbConfig::CONFIG['target_os'] =~ /linux/i
      gem 'rb-inotify', '>= 0.5.1'
      gem 'libnotify',  '~> 0.1.3'
    end
  end
end

if !ENV['TRAVIS'] || ENV['DB'] == 'postgresql'
  gem 'activerecord-jdbcpostgresql-adapter', platform: :jruby
  gem 'pg', platform: :ruby
end

# Load local gems according to Refinery developer preference.
if File.exist? local_gemfile = File.expand_path('../.gemfile', __FILE__)
  eval File.read(local_gemfile)
end

