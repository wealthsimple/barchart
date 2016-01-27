# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "barchart/version"

Gem::Specification.new do |gem|
  gem.name          = "barchart"
  gem.version       = Barchart::VERSION
  gem.authors       = ["Karney Li"]
  gem.email         = ["karney@wealthsimple.com"]
  gem.description   = %q{}
  gem.summary       = %q{}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rest-client"
  gem.add_dependency "activesupport"
  gem.add_dependency "recursive-open-struct"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rspec-its"
  gem.add_development_dependency "rspec-collection_matchers"
  gem.add_development_dependency "webmock"
  gem.add_development_dependency "factory_girl"
  gem.add_development_dependency "pry"
end
