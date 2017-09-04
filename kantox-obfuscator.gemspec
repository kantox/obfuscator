# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'kantox-obfuscator'
  s.version     = '0.0.1'
  s.date        = '2017-09-04'
  s.summary     = 'Obfuscate data for logging purpose'
  s.description = <<-EOF
    A class that's capable of obfuscating strings and hashes.
  EOF
  s.authors     = ['Kantox']
  s.email       = 'saverio.trioni@kantox.com'
  s.files       = %w[
    lib/kantox-obfuscator.rb
    lib/kantox/obfuscator.rb
  ]
  s.homepage    = 'http://kantox.com'
  s.license     = 'MIT'

  s.add_runtime_dependency 'dry-initializer', '~> 2.0'

  s.add_development_dependency 'rspec'
end
