# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cucumber_tricks/version'

Gem::Specification.new do |spec|
  spec.name          = "cucumber_tricks"
  spec.version       = CucumberTricks::VERSION
  spec.authors       = ["Philou"]
  spec.email         = ["philippe.bourgau@gmail.com"]
  spec.description   = %q{Cucumber step definition dsl extension to easily define more readable steps}
  spec.summary       = %q{Allows to reference entities with pronouns in gherkin, and to have dual steps, taking a single parameter, or a more detailed table.}
  spec.homepage      = "https://github.com/philou/cucumber_tricks"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "cucumber"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "guard-cucumber"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "relish"
  spec.add_development_dependency "codeclimate-test-reporter"
end
