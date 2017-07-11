$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "chat_bot/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "chat_bot"
  s.version     = ChatBot::VERSION
  s.authors     = ["Anuja Ware"]
  s.email       = ["anuja@joshsoftware.com"]
  s.homepage    = "https://github.com/anujaware/chat-bot.git"
  s.summary     = "ChatBot."
  s.description = "Create decision tree of dialogues and options to chat with user i.e. predefined set of dialogue and options."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.required_ruby_version = '~> 2.1'

  s.add_dependency "rails", "~> 4.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 3.4"
end
