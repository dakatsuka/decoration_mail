require 'rake'
require 'rspec/core/rake_task'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :spec

desc 'Test the decoration_mail plugin.'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = ['-c --backtrace']
end

desc 'Generate documentation for the decoration_mail plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'DecorationMail'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "decoration_mail"
    gemspec.summary = "Decoration Mail Parser"
    gemspec.email = "d.akatsuka@gmail.com"
    gemspec.homepage = "https://github.com/dakatsuka/decoration_mail"
    gemspec.description = "Decoration Mail Parser"
    gemspec.authors = ["Dai Akatsuka"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
