# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'google/api_calendar/version'

Gem::Specification.new do |spec|
  spec.name          = 'google-api-calendar'
  spec.version       = Google::APICalendar::VERSION
  spec.authors       = ['Vadim Vorotilov']
  spec.email         = ['fant.geass@gmail.com']
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = 'https://github.com/fantgeass/google-api-calendar'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.1.0'

  spec.add_dependency 'google-api-client', '~> 0.7.1'
end
