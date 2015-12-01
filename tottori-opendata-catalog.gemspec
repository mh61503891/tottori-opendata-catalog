lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tottori-opendata-catalog/version'

Gem::Specification.new do |spec|
  spec.name          = 'tottori-opendata-catalog'
  spec.version       = TottoriOpenDataCatalog::VERSION
  spec.authors       = ['Masayuki Higashino']
  spec.email         = ['mh.on.web@gmail.com']
  spec.summary       = 'An API and a CLI for Open Data Catalog of Tottori Prefecture.'
  spec.description   = 'An API and a CLI for Open Data Catalog of Tottori Prefecture.'
  spec.homepage      = 'https://github.com/mh61503891/tottori-opendata-catalog'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.1.0'

  spec.add_dependency 'thor', '~> 0.19.1'
  spec.add_dependency 'nokogiri', '~> 1.6.7'
  spec.add_development_dependency 'bundler', '~> 1.10.6'
  spec.add_development_dependency 'awesome_print', '~> 1.6.1'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'facets'
end
