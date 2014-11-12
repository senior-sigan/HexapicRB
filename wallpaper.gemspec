# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wallpaper/version'

Gem::Specification.new do |spec|
  spec.name          = 'wallpaper'
  spec.version       = Wallpaper::VERSION
  spec.authors       = ['Ilya Siganov']
  spec.email         = ['ilya.blan4@gmail.com']
  spec.summary       = 'Set desktop wallpaper from social networks'
  #spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'
  spec.add_runtime_dependency 'flickr.rb', '~> 1.2.1' 
end
