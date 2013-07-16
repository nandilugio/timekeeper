# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'timekeeper/version'

Gem::Specification.new do |gem|
  gem.name          = "timekeeper"
  gem.version       = Timekeeper::VERSION
  gem.authors       = ["Fernando Gessler"]
  gem.email         = ["fernando.gessler@socialpoint.es"]
  gem.description   = %q{Keep track of your time.}
  gem.summary       = %q{Tracks your time .... TODO}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "activerecord"
  gem.add_dependency "thor"
  gem.add_dependency "sqlite3"
  
  gem.add_development_dependency "rspec"
end

