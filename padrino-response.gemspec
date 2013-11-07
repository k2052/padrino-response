# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "padrino-response/version"

Gem::Specification.new do |s|
  s.name        = "padrino-response"
  s.version     = Padrino::Response::VERSION
  s.authors     = ["K-2052"]
  s.email       = ["k@2052.me"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "padrino-response"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "adapter"
  s.add_development_dependency "toystore"
  s.add_development_dependency "rack-test"
  s.add_dependency "padrino", ">= 0.10.7"
  s.add_dependency "rake"
  s.add_dependency "sinatra-flash", ">= 0.3.0"
end
