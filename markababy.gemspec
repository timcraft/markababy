Gem::Specification.new do |s|
  s.name = 'markababy'
  s.version = '1.1.0'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Tim Craft']
  s.email = ['mail@timcraft.com']
  s.homepage = 'http://github.com/timcraft/markababy'
  s.description = 'Markaby\'s little sister'
  s.summary = 'See description'
  s.files = Dir.glob('{lib,spec}/**/*') + %w(README.txt Rakefile markababy.gemspec)
  s.add_development_dependency('rails', ['>= 3.0.3'])
  s.require_path = 'lib'
end
