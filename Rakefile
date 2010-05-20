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
  t.files   = ['lib/**/*.rb', "README.md", "LICENCE.md"]
  t.options = ['--output-dir', 'doc/api']
end

desc "Generates the github pages" 
task :pages do 
  `./doc/pages/generate "http://blambeau.github.com/sbyc/" ./doc/gh-pages`
end

gemspec = Gem::Specification.new do |s|
  s.name = 'sbyc'
  s.version = version
  s.summary = "SByC - Specialization By Constraint"
  s.description = %{A new Typing System on top of Ruby}
  s.files = Dir['lib/**/*'] + Dir['test/**/*'] + Dir['bin/*']
  s.require_path = 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.md", "LICENCE.md"]
  s.rdoc_options << '--title' << 'SByC - A new Typing System through Specialization By Constraint' <<
                    '--main' << 'README.md' <<
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
