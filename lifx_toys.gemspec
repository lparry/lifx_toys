# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lifx_toys/version'

Gem::Specification.new do |spec|
  spec.name          = "lifx_toys"
  spec.version       = LifxToys::VERSION
  spec.authors       = ["Lucas Parry"]
  spec.email         = ["lparry@gmail.com"]

  spec.summary       = %q{Lucas's LIFX toys}
  spec.description   = %q{ruby wrapper and toys for the LIFX cloud api}
  spec.homepage      = "https://github.com/lparry/lifx_toys"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.7"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_dependency             "json", "~> 1.8"
  spec.add_dependency             "httparty", "~> 0.13"
end
