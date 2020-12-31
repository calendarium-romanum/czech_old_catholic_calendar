# coding: utf-8
require_relative 'lib/czech_old_catholic_calendar/version'

Gem::Specification.new do |spec|
  spec.name          = 'czech_old_catholic_calendar'
  spec.version       = CzechOldCatholicCalendar::VERSION
  spec.authors       = ['Jakub Pavlík']
  spec.email         = ['jkb.pavlik@gmail.com']

  spec.summary       = %q{Library computing liturgical calendar of the Czech Old Catholic Church}
  spec.homepage      = 'https://github.com/calendarium-romanum/czech_old_catholic_calendar'
  spec.licenses      = ['MIT']

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'calendarium-romanum', '~> 0.8.0'
end
