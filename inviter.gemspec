$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "inviter/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "inviter"
  s.version     = Inviter::VERSION
  s.authors     = ["Manuel Morales"]
  s.email       = ["morales.jmanuel16@gmail.com"]
  s.homepage    = "https://github.com/mjmorales/inviter"
  s.summary     = "A Light weight invitation system for Ruby on Rails."
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">=5.1.4"

  s.add_development_dependency "sqlite3"
end
