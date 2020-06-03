# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-caststone'
  s.version           = '3.0.1'
  s.description       = 'Ruby on Rails Caststone extension for Refinery CMS'
  s.date              = '2012-05-07'
  s.summary           = 'Caststone extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.authors            = 'Anita Graham'
  s.licenses          = %q{MIT}

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")

  # Runtime dependencies
  s.add_dependency    'refinerycms-core'
  s.add_dependency    'refinerycms-acts-as-indexed'
  s.add_dependency    'rmagick'
  s.add_dependency    'mime-types'
  s.add_dependency    'mustache'
  s.add_dependency    'stache'
  s.add_dependency    'gutentag'

end

