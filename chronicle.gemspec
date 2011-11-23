# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "chronicle/version"

Gem::Specification.new do |s|
  s.name        = "chronicle"
  s.version     = Chronicle::VERSION
  s.authors     = ["Ben Rady"]
  s.email       = ["benrady@gmail.com"]
  s.homepage    = "benrady.github.com/chronicle"
  s.summary     = %q{TODO: Library and command line tool for filling out forms scanned as images}
  s.description = %q{TODO: Chronicle can use used to generate filled out and signed forms from a png, jpg or other scanned image of a form.}

  s.rubyforge_project = "chronicle"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "guard"
  # s.add_runtime_dependency "rest-client"
  # s.add_runtime_dependency "rmagic"
end
