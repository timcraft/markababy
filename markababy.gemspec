Gem::Specification.new do |s|
  s.name = 'markababy'
  s.version = '1.2.0'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Tim Craft']
  s.email = ['mail@timcraft.com']
  s.homepage = 'http://github.com/timcraft/markababy'
  s.description = 'Markaby\'s little sister'
  s.summary = 'See description'
  s.files = Dir.glob('{lib,spec}/**/*') + %w(README.md Rakefile markababy.gemspec)
  s.add_development_dependency('rails', ['>= 3.0.3'])
  s.require_path = 'lib'

  unless defined?(BasicObject)
    s.add_dependency('backports', '~> 2.8.2')
  end

  if RUBY_VERSION == '1.8.7'
    s.add_development_dependency('minitest', '>= 4.2.0')
  end
end
