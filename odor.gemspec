# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "odor/version"

Gem::Specification.new do |s|
  s.name        = "odor"
  s.version     = Odor::VERSION
  s.authors     = ["Dave Elliott"]
  s.email       = ["ddazza@gmail.com"]
  s.homepage    = "https://github.com/davidelliott/"
  s.summary     = %q{Lists smells in code changes}
  s.description = %q{Outputs a list of bits of code which should be reviewed as they could potentialy lead to later problem from current code changes}

  s.rubyforge_project = "odor"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
end
