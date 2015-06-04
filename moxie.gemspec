# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'moxie/version'

Gem::Specification.new do |spec|
  spec.name          = "moxie"
  spec.version       = Moxie::VERSION
  spec.authors       = ["Casey O'Hara"]
  spec.email         = ["casey@camber.io"]
  spec.summary       = "$ mox"
  spec.homepage      = "https://github.com/camber/moxie"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ['moxie', 'mox']
  spec.require_paths = ["lib"]

  spec.add_dependency "hashie", "~> 3.4.1"
  spec.add_dependency "redis", "~> 3.2.1"
  spec.add_dependency "redis-namespace", "~> 1.5.2"
  spec.add_dependency "thor", "~> 0.19.1"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2.0"
  spec.add_development_dependency "factory_girl", "~> 4.5.0"
  spec.add_development_dependency "mock_redis", "~> 0.14.1"
end

