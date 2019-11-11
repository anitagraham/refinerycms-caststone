source "http://rubygems.org"

gemspec

gem 'refinerycms', git: "https://github.com/refinery/refinerycms", branch: 'master'
gem 'refinerycms-acts-as-indexed',  git: 'https://github.com/refinery/refinerycms-acts-as-indexed'
gem 'mime-types', '~> 3.1'
gem 'mustache'
gem 'stache'

# Database Configuration
# unless ENV['TRAVIS']
#   gem 'activerecord-jdbcsqlite3-adapter', platform: :jruby
#   gem 'sqlite3', platform: :ruby
# end
#
# if !ENV['TRAVIS'] || ENV['DB'] == 'mysql'
#   gem 'activerecord-jdbcmysql-adapter', platform: :jruby
#   gem 'jdbc-mysql', '= 5.1.13', platform: :jruby
#   gem 'mysql2', platform: :ruby
# end
#
# if !ENV['TRAVIS'] || ENV['DB'] == 'postgresql'
#   gem 'activerecord-jdbcpostgresql-adapter', platform: :jruby
#   gem 'pg', platform: :ruby
# end


# Load local gems according to Refinery developer preference.
if File.exist? (local_gemfile = File.expand_path('../.gemfile', __FILE__))
  eval File.read(local_gemfile)
end
