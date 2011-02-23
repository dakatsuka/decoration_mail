# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{decoration_mail}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dai Akatsuka"]
  s.date = %q{2011-02-08}
  s.description = %q{Decoration Mail Parser}
  s.email = %q{d.akatsuka@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "MIT-LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "init.rb",
    "lib/decoration_mail.rb",
    "lib/decoration_mail/base.rb",
    "lib/decoration_mail/converter.rb",
    "lib/decoration_mail/image.rb",
    "lib/decoration_mail/message.rb",
    "spec/resources/au_decoration.eml",
    "spec/resources/au_decoration_with_attachment.eml",
    "spec/resources/docomo_decoration.eml",
    "spec/resources/docomo_decoration_with_attachment.eml",
    "spec/resources/softbank_decoration.eml",
    "spec/resources/softbank_decoration_with_attachment.eml",
    "spec/spec_helper.rb",
    "spec/unit/base_spec.rb",
    "spec/unit/converter_spec.rb"
  ]
  s.homepage = %q{https://github.com/dakatsuka/decoration_mail}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Decoration Mail Parser}
  s.test_files = [
    "spec/spec_helper.rb",
    "spec/unit/base_spec.rb",
    "spec/unit/converter_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mail>, [">= 2.2.15"])
      s.add_runtime_dependency(%q<hpricot>, [">= 0.8.3"])
      s.add_development_dependency(%q<rspec>, [">= 2.0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<mail>, [">= 2.2.15"])
      s.add_dependency(%q<hpricot>, [">= 0.8.3"])
      s.add_dependency(%q<rspec>, [">= 2.0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<mail>, [">= 2.2.15"])
    s.add_dependency(%q<hpricot>, [">= 0.8.3"])
    s.add_dependency(%q<rspec>, [">= 2.0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end
