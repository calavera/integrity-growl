Gem::Specification.new do |s|
  s.name              = 'integrity-growl'
  s.version           = '1.0'
  s.date              = '2009-01-17'
  s.summary           = 'Growl notifier for the Integrity continuous integration server'
  s.description       = 'Easily let Integrity show Growl notifications after each build'
  s.homepage          = 'http://integrityapp.com'
  s.email             = 'calavera@apache.org'
  s.authors           = ['David Calavera']
  s.has_rdoc          = false
  s.files             = %w( README.markdown lib/notifier/growl.rb )
 
  s.add_dependency 'foca-integrity'
  s.add_dependency 'ruby-growl'
end