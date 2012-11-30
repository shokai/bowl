lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fishbowl/version'

Gem::Specification.new do |gem|
  gem.name          = "fishbowl"
  gem.version       = Fishbowl::VERSION
  gem.authors       = ["Sho Hashimoto"]
  gem.email         = ["hashimoto@shokai.org"]
  gem.description   = %q{FishBowl is a Mac/Linux controller for your Application.}
  gem.summary       = %q{Write Ruby Code, put it into plug-in directory. FishBowl automatically generate sample code and Web UI.}
  gem.homepage      = "https://github.com/shokai/fishbowl"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rack'
  gem.add_dependency 'sinatra', '> 1.3.0'
  gem.add_dependency 'eventmachine'
  gem.add_dependency 'thin'
  gem.add_dependency 'sinatra-contrib', '> 1.3.0'
  gem.add_dependency 'sinatra-cometio'
  gem.add_dependency 'json'
  gem.add_dependency 'haml'
  gem.add_dependency 'sass'
  gem.add_dependency 'hashie'
  gem.add_dependency 'args_parser', '> 0.1.0'
  gem.add_dependency 'arduino_firmata'
end
