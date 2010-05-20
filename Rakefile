require "rubygems"
require "rake/rdoctask"
require "rake/testtask"
require 'spec/rake/spectask'
require "rake/gempackagetask"
require "yard"

dir     = File.dirname(__FILE__)
lib     = File.join(dir, "lib", "sbyc.rb")
version = File.read(lib)[/^\s*VERSION\s*=\s*(['"])(\d\.\d\.\d)\1/, 2]

task :default => [:test]

desc "Run all rspec test"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.ruby_opts = ['-I.']
  t.spec_files = FileList['test/spec/test_all.rb']
end

desc "Launches all tests"
task :test => [:spec]

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
  t.options = ['--output-dir', 'doc/api', '-', "README.textile", "LICENCE.textile", "CHANGELOG.textile"]
end

desc "Generates the github pages" 
task :pages do 
  `./doc/pages/generate "http://blambeau.github.com/sbyc/" ./doc/gh-pages`
  #puts `cd doc/gh-pages && git commit -a -m 'Documentation improved.' && git push origin && cd ../..`
end

gemspec = Gem::Specification.new do |s|
  s.name = 'sbyc'
  s.version = version
  s.summary = "SByC - Specialization By Constraint"
  s.description = %{Tools around Ruby and Types}
  s.files = Dir['lib/**/*'] + Dir['test/**/*']
  s.require_path = 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.textile", "LICENCE.textile"]
  s.rdoc_options << '--title' << 'SByC - SByC - Specialization By Constraint' <<
                    '--main' << 'README.textile' <<
                    '--line-numbers'  
  s.bindir = "bin"
  s.executables = []
  s.author = "Bernard Lambeau"
  s.email = "blambeau@gmail.com"
  s.homepage = "http://github.com/blambeau/sbyc"
end
Rake::GemPackageTask.new(gemspec) do |pkg|
	pkg.need_tar = true
end
