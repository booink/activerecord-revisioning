$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "activerecord/revisioning/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activerecord-revisioning"
  s.version     = ActiveRecord::Revisioning::VERSION
  s.authors     = ["booink"]
  s.email       = ["booink.work@gmail.com"]
  s.summary     = "changes per tables"
  s.description = s.summary
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.1"
end
