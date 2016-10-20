# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pandago/version'

Gem::Specification.new do |spec|
  spec.name          = "pandago"
  spec.version       = PandaGo::VERSION
  spec.authors       = ["Tony Ta"]
  spec.email         = ["tonyta.tt@gmail.com"]

  spec.summary       = "A lightweight Ruby Wrapper for PandaGo (Pandoc served with Go)"
  spec.homepage      = "https://github.com/scripted/pandago-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.3.0'

  spec.add_development_dependency "bundler", "~> 1.13.3"
  spec.add_development_dependency "rake", "~> 10.5.0"
  spec.add_development_dependency "rspec", "~> 3.5.0"
  spec.add_development_dependency "rspec-its", "~> 1.2.0"
  spec.add_development_dependency "pry", "~> 0.10.4"
  spec.add_development_dependency "pry-byebug", "~> 3.4.0"
  spec.add_development_dependency "webmock", "~> 2.1.0"
  spec.add_development_dependency "coveralls", "~> 0.8.15"
end
