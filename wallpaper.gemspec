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
  spec.description   = "Pick a random pic from flickr and set it as Linux's background."
  spec.homepage      = 'https://bitbucket.org/senior_sigan/wallpaper_rb'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.requirements << 'imagemagick'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.4'
  spec.add_runtime_dependency 'choice', '~> 0.1'
  spec.add_runtime_dependency 'flickr.rb', '~> 1.2' 
  spec.add_runtime_dependency 'instagram', '~> 1.1'
  spec.add_runtime_dependency 'mini_magick', '~> 4.0'
end
