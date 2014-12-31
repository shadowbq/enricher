# -*- encoding: utf-8 -*-
require File.expand_path('../lib/enricher/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["shadowbq"]
  gem.email         = ["shadowbq@gmail.com"]
  gem.description   = %q{Enricher, the IP and URL data enhancer}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/shadowbq/enricher"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "enricher"
  gem.require_paths = ["lib"]
  gem.version       = Enricher::VERSION
  gem.licenses      = ["MIT"]
  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_dependency "geoip", '~> 1.2'
  gem.add_dependency "netaddr", '~> 1.5'
  gem.add_dependency "net/dns", '~> 0.8'
  gem.add_dependency "rest-client"
  gem.add_dependency "json"

end
