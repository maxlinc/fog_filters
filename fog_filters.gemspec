# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fog_filters/version'

Gem::Specification.new do |spec|
  spec.name          = "fog_filters"
  spec.version       = FogFilters::VERSION
  spec.authors       = ["Max Lincoln"]
  spec.email         = ["max@devopsy.com"]
  spec.description   = %q{FogFilters are reusable filters for projects using VCR.}
  spec.summary       = %q{This project is to make it easier to filter out sensitive data or unnecessary interactions (e.g. removing "BUILD" states to speed up tests).  You should still carefully review all your recorded cassettes before pushing to GitHub, to make sure you haven't recorded sensitive or unnecessary data.}
  spec.homepage      = "https://github.com/maxlinc/fog_filters"
  spec.license       = "Apache v2"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "fog"
  spec.add_dependency "vcr"
  spec.add_dependency "multi_json"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
end
