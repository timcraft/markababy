Gem::Specification.new do |s|
  s.name = 'markababy'
  s.version = '1.3.0'
  s.license = 'LGPL-3.0'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Tim Craft']
  s.email = ['mail@timcraft.com']
  s.homepage = 'https://github.com/timcraft/markababy'
  s.description = 'Markaby\'s little sister'
  s.summary = 'See description'
  s.files = Dir.glob('{lib,spec}/**/*') + %w(LICENSE.txt README.md Rakefile markababy.gemspec)
  s.required_ruby_version = '>= 1.9.3'
  s.add_development_dependency('rake', '>= 12')
  s.add_development_dependency('rails', '~> 5')
  s.add_development_dependency('minitest', '5.11.0')
  s.require_path = 'lib'
end
