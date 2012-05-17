# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rails_kindeditor/version"

Gem::Specification.new do |s|
  s.name        = "rails_kindeditor"
  s.version     = RailsKindeditor::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = "Macrow"
  s.email       = "Macrow_wh@163.com"
  s.homepage    = "http://github.com/Macrow"
  s.summary     = "Kindeditor for Ruby on Rails"
  s.description = "rails_kindeditor will helps your rails app integrate with kindeditor, including images and files uploading."

  s.rubyforge_project = "rails_kindeditor"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency("carrierwave")
  s.add_dependency("carrierwave-mongoid")
  s.add_dependency("mini_magick")
end