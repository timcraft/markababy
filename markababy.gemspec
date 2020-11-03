Gem::Specification.new do |s|
  s.name = 'markababy'
  s.version = '1.3.1'
  s.license = 'LGPL-3.0'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Tim Craft']
  s.email = ['mail@timcraft.com']
  s.homepage = 'https://github.com/timcraft/markababy'
  s.description = 'Markaby\'s little sister'
  s.summary = 'See description'
  s.files = Dir.glob('lib/**/*.rb') + %w(LICENSE.txt README.md markababy.gemspec)
  s.required_ruby_version = '>= 1.9.3'
  s.require_path = 'lib'
  s.metadata = {
    'homepage' => 'https://github.com/timcraft/markababy',
    'source_code_uri' => 'https://github.com/timcraft/markababy',
    'bug_tracker_uri' => 'https://github.com/timcraft/markababy/issues'
  }
end
