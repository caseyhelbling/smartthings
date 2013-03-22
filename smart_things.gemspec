# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'smart_things/version'

Gem::Specification.new do |gem|
  gem.name        = "smart_things"
  gem.summary     = ""
  gem.description = ""
  gem.homepage    = "http://github.com/caseyhelbling/smartthings"
  gem.version     = SmartThings::VERSION
  gem.licenses    = ['MIT']

  gem.authors     = ["Casey Helbling"]
  gem.email       = "casey@softwareforgood.com"

  gem.require_paths  = ["lib"]
  gem.files          = `git ls-files`.split("\n")
  gem.test_files     = `git ls-files -- {spec}/*`.split("\n")
  gem.executables    = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  gem.extra_rdoc_files = ["readme.md"]

  #gem.rdoc_options     = ["--line-numbers", "--inline-source", "--title", "SmartThings"]

  gem.add_runtime_dependency("multi_json")
  gem.add_runtime_dependency("faraday")
  gem.add_runtime_dependency("faraday_middleware")
  #gem.add_runtime_dependency("addressable")
  #gem.add_development_dependency("rspec")
  gem.add_development_dependency("rake")
  
end

