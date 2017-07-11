$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "chat_bot/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "chat_bot"
  s.version     = ChatBot::VERSION
  s.authors     = ["Anuja Ware"]
  s.email       = ["anuja@joshsoftware.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ChatBot."
  s.description = "TODO: Description of ChatBot."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.7.1"

  s.add_development_dependency "sqlite3"
end
