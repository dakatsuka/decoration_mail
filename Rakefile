require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'rdoc/task'

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
