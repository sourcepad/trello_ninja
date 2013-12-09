# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trello_ninja/version'

Gem::Specification.new do |spec|
  spec.name          = "trello_ninja"
  spec.version       = TrelloNinja::VERSION
  spec.authors       = ["Migz Suelto"]
  spec.email         = ["michaels@sourcepad.com"]
  spec.description   = "Trello API Ruby Wrapper"
  spec.summary       = "trello api"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_runtime_dependency "json"
  spec.add_runtime_dependency "representable"
end
