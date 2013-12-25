# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'decoration_mail/version'

Gem::Specification.new do |spec|
  spec.name          = "decoration_mail"
  spec.version       = DecorationMail::VERSION
  spec.authors       = ["Dai Akatsuka", "M.Shibuya"]
  spec.email         = ["d.akatsuka@gmail.com", "mit.shibuya@gmail.com"]
  spec.description   = %q{Decoration Mail Parser}
  spec.summary       = %q{Decoration Mail Parser}
  spec.homepage      = "https://github.com/dakatsuka/decoration_mail"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "mail", "~> 2.2"
  spec.add_dependency "nokogiri"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "debugger"
end
