# Encoding: UTF-8
# Encoding: UTF-8
# $:.push File.expand_path('../lib', __FILE__)
# require 'refinery/caststone/version'
#
# version = Refinery::Caststone::Version.to_s

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-caststone'
  s.version           = '1.0.3'
  s.description       = 'Ruby on Rails Caststone extension for Refinery CMS'
  s.date              = '2012-05-07'
  s.summary           = 'Caststone extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.authors            = 'Anita Graham'
  s.licenses          = %q{MIT}

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")

  # Runtime dependencies
  s.add_dependency    'refinerycms-core'  #,    '~> 2.1.0'
  s.add_dependency    'rmagick'
  s.add_dependency    'mustache'
  s.add_dependency    'stache'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing'
end

