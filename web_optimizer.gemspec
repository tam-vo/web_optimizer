# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'web_optimizer/version'

Gem::Specification.new do |gem|
  gem.name          = "web_optimizer"
  gem.license       = "MIT"
  gem.version       = WebOptimizer::VERSION
  gem.authors       = ["Tam Vo"]
  gem.email         = ["vo.mita.ov@gmail.com"]
  gem.description   = %q{Compress all css file in specified dir with yuicompressor}
  gem.summary       = %q{Compress css, js and optimize images tools}
  gem.homepage      = "http://github.com/tamvo/web_optimizer"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency("activesupport")
  gem.add_dependency("fileutils")
  gem.add_dependency("mechanize")
  gem.add_dependency("byebug")
end

