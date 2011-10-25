# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "capistrano/tomcat/version"

Gem::Specification.new do |s|
  s.name        = "capistrano-tomcat"
  s.version     = Capistrano::Tomcat::VERSION
  s.authors     = ["Rob Hunter"]
  s.email       = ["rhunter@thoughtworks.com"]
  s.homepage    = ""
  s.summary     = %q{Deployment recipes for deploying to Tomcat at OVE}
  s.description = %q{Apache Tomcat, a Java servlet container, runs WARs

    These deployment recipes help to run a Tomcat instance with your
    own WAR files from Capistrano.
  }

  s.rubyforge_project = "capistrano-tomcat"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "capistrano"
end
