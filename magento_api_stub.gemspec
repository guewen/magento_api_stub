# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "magento_api_stub/version"

Gem::Specification.new do |s|
  s.name        = "magento_api_stub"
  s.version     = MagentoAPIStub::VERSION
  s.authors     = ["Guewen Baconnier"]
  s.email       = ["guewen.baconnier@camptocamp.com"]
  s.homepage    = ""
  s.summary     = %q{Magento API Stub: Middleware between Magento API and Client}
  s.description = %q{Can be used as middleware between Magento API and a client, but also to fake magento in order to run automation tests for external system based on the Magento's API' without a running Magento instance.}

  s.rubyforge_project = "magento_api_stub"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
