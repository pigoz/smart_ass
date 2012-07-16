# -*- encoding: utf-8 -*-
require File.expand_path('../lib/smart_ass/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Stefano Pigozzi"]
  gem.email         = ["stefano.pigozzi@gmail.com"]
  gem.description   = %q{Utility for YCbCr ColorMatrix conversion of ASS Subtitles.}
  gem.summary       = %q{Utility for YCbCr ColorMatrix conversion of ASS Subtitles.}
  gem.homepage      = "http://github.com/pigoz/smart_ass"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "smart_ass"
  gem.require_paths = ["lib"]
  gem.version       = SmartAss::VERSION
end
