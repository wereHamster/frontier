require File.expand_path('../lib/frontier/version', __FILE__)

Gem::Specification.new do |s|
  s.name         = 'frontier'
  s.homepage     = 'http://github.com/wereHamster/frontier'
  s.summary      = 'Ruby without borders'
  s.require_path = 'lib'
  s.authors      = ['Tomas Carnecky']
  s.email        = ['tomas.carnecky@gmail.com']
  s.version      = Frontier::Version
  s.platform     = Gem::Platform::RUBY
  s.files        = Dir.glob("lib/**/*") + %w[LICENSE README.md]
  s.executables  = ["frontier"]

  s.add_development_dependency 'rake', '~> 0.8'
  s.add_development_dependency 'shoulda', '~> 2.11'
end
