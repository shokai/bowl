lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bowl/version'

Gem::Specification.new do |gem|
  gem.name          = "bowl"
  gem.version       = Bowl::VERSION
  gem.authors       = ["Sho Hashimoto"]
  gem.email         = ["hashimoto@shokai.org"]
  gem.description   = %q{Bowl is a Mac/Linux controller for your Application.}
  gem.summary       = %q{Write Ruby Code, put it into plug-in directory. Bowl automatically generate sample code and Web UI.}
  gem.homepage      = "https://github.com/shokai/bowl"

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
  gem.add_dependency 'arduino_firmata', '>= 0.1.6'
end
