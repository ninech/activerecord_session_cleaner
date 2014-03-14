# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = 'activerecord_session_cleaner'
  s.version     = File.read(File.expand_path('../VERSION', __FILE__)).strip
  s.authors     = ['Nils Caspar']
  s.email       = 'info@nine.ch'
  s.homepage    = 'https://github.com/ninech/activerecord_session_cleaner'
  s.license     = 'MIT'
  s.summary     = 'Gem to remove old sessions from your ActiveRecord DB'
  s.description = 'This gem allows you to automatically remove old sessions from your ActiveRecord.'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'rake', '~> 10.0'

  s.add_runtime_dependency 'whenever', '~> 0.9'
end
