# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shade/version'

Gem::Specification.new do |spec|
  spec.name          = 'shade'
  spec.version       = Shade::VERSION
  spec.authors       = ['Matthew McEachen']
  spec.email         = ['matthew+github@mceachen.org']
  spec.summary       = %q{Coalesce colors to a given palette}
  spec.description   = %q{Using CIE L*a*b* and kdtrees, take a color (from LESS, SCSS, or other
                       inputs) and find the nearest shade of color from a given palette}
  spec.homepage      = 'https://github.com/mceachen/shade'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'geokdtree'
  spec.add_runtime_dependency 'color'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'minitest-great_expectations'
  spec.add_development_dependency 'minitest-reporters'
end
