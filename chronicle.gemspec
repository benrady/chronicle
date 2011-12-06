# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "chronicle/version"

Gem::Specification.new do |s|
  s.name        = "chronicle"
  s.version     = Chronicle::VERSION
  s.authors     = ["Ben Rady"]
  s.email       = ["benrady@gmail.com"]
  s.homepage    = "http://benrady.github.com/chronicle"
  s.summary     = %q{Fills out chronicle sheets for Pathfinder Society GMs}
  s.description = %q{Chronicle makes it easy for Pathfinder Society GM's to collect player info and generate chronicle sheets right from the scenario PDFs.}

  s.rubyforge_project = "chronicle"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.platform=Gem::Platform::CURRENT

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
end
