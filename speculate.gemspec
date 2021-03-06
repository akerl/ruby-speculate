require 'English'
$LOAD_PATH.unshift File.expand_path('../lib/', __FILE__)
require 'speculate/version'

Gem::Specification.new do |s|
  s.name        = 'speculate'
  s.version     = Speculate::VERSION
  s.date        = Time.now.strftime('%Y-%m-%d')

  s.summary     = 'Tool for assuming roles in AWS accounts'
  s.description = 'Tool for assuming roles in AWS accounts'
  s.authors     = ['Les Aker']
  s.email       = 'me@lesaker.org'
  s.homepage    = 'https://github.com/akerl/speculate'
  s.license     = 'MIT'

  s.files       = `git ls-files`.split
  s.test_files  = `git ls-files spec/*`.split
  s.executables = ['speculate']

  s.add_dependency 'aws-sdk', '~> 3.0.0'
  s.add_dependency 'mercenary', '~> 0.3.4'
  s.add_dependency 'userinput', '~> 1.0.0'

  s.add_development_dependency 'codecov', '~> 0.1.1'
  s.add_development_dependency 'fuubar', '~> 2.2.0'
  s.add_development_dependency 'goodcop', '~> 0.1.0'
  s.add_development_dependency 'rake', '~> 12.1.0'
  s.add_development_dependency 'rspec', '~> 3.7.0'
  s.add_development_dependency 'rubocop', '~> 0.51.0'
end
